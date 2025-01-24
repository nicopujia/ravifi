import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_sqlite/memory_cache_provider.dart';
import 'package:brick_supabase/brick_supabase.dart' hide Supabase;
import 'package:sqflite_common/sqlite_api.dart';
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

  static Future<void> configure(DatabaseFactory databaseFactory) async {
    final (client, queue) = OfflineFirstWithSupabaseRepository.clientQueue(
      databaseFactory: databaseFactory,
    );

    const supabaseUrl = 'https://wtoogpnklxkpqaxjbudb.supabase.co';
    // ignore: unnecessary_const
    const supabaseAnonKey = const String.fromEnvironment('SUPABASE_KEY');
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      httpClient: client,
    );

    final provider = SupabaseProvider(
      Supabase.instance.client,
      modelDictionary: supabaseModelDictionary,
    );

    _instance = Repository._(
      supabaseProvider: provider,
      sqliteProvider: SqliteProvider(
        'my_repository.sqlite',
        databaseFactory: databaseFactory,
        modelDictionary: sqliteModelDictionary,
      ),
      migrations: migrations,
      offlineRequestQueue: queue,
      memoryCacheProvider: MemoryCacheProvider(),
    );
  }
}
