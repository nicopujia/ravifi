import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_sqlite/memory_cache_provider.dart';
import 'package:brick_supabase/brick_supabase.dart' hide Supabase;
import 'package:sqflite/sqflite.dart'
    show DatabaseFactory, inMemoryDatabasePath;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'brick.g.dart';
import 'db/schema.g.dart';

class Repository extends OfflineFirstWithSupabaseRepository {
  static late Repository? _instance;

  Repository._({
    required super.supabaseProvider,
    required super.sqliteProvider,
    required super.migrations,
    required super.offlineRequestQueue,
    super.memoryCacheProvider,
  });

  factory Repository() => _instance!;

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
