import 'dart:io';

import 'package:brick_offline_first/brick_offline_first.dart';
import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_sqlite/memory_cache_provider.dart';
import 'package:brick_supabase/brick_supabase.dart' hide Supabase;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart'
    show DatabaseFactory, inMemoryDatabasePath;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/logs/models/log.model.dart';
import 'brick.g.dart';
import 'db/schema.g.dart';

class Repository extends OfflineFirstWithSupabaseRepository {
  static late final Repository? _instance;
  static late final Directory _cacheDir;

  Repository._({
    required super.supabaseProvider,
    required super.sqliteProvider,
    required super.migrations,
    required super.offlineRequestQueue,
    super.memoryCacheProvider,
  });

  factory Repository() => _instance!;

  static Directory get cacheDir => _cacheDir;

  @override
  Future<void> initialize() async {
    _cacheDir = await getApplicationCacheDirectory();
    return super.initialize();
  }

  @override
  Future<bool> delete<TModel extends OfflineFirstWithSupabaseModel>(
    instance, {
    OfflineFirstDeletePolicy policy = OfflineFirstDeletePolicy.optimisticLocal,
    Query? query,
  }) async {
    if (instance is Log) {
      await (instance as Log).deletePhoto();
    }
    return super.delete(instance, policy: policy, query: query);
  }

  static Future<void> initializeSupabaseAndConfigure(
    DatabaseFactory databaseFactory,
  ) async {
    final (client, queue) = OfflineFirstWithSupabaseRepository.clientQueue(
      databaseFactory: databaseFactory,
    );

    final supabase = await Supabase.initialize(
      url: 'https://wtoogpnklxkpqaxjbudb.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0b29ncG5rbHhrcHFheGpidWRiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc2NTI5MTgsImV4cCI6MjA1MzIyODkxOH0.RgkRWyHRXfX8aIz8nI0IDYLjxDu5eNRp_hw9qQl6jJA',
      httpClient: client,
    );

    final provider = SupabaseProvider(
      supabase.client,
      modelDictionary: supabaseModelDictionary,
    );

    _instance = Repository._(
      supabaseProvider: provider,
      sqliteProvider: SqliteProvider(
        inMemoryDatabasePath,
        databaseFactory: databaseFactory,
        modelDictionary: sqliteModelDictionary,
      ),
      migrations: migrations,
      offlineRequestQueue: queue,
      memoryCacheProvider: MemoryCacheProvider(),
    );
  }
}
