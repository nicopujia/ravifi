// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<Log> _$LogFromSupabase(Map<String, dynamic> data,
    {required SupabaseProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return Log(
      date: DateTime.parse(data['date'] as String),
      weight: data['weight'] as double,
      height: data['height'] as double,
      squat: data['squat'] as double,
      pullUp: data['pull_up'] as double,
      benchPress: data['bench_press'] as double,
      deadlift: data['deadlift'] as double,
      distance: data['distance'] as double,
      timeRunning: data['time_running'] as double,
      id: data['id'] as String?);
}

Future<Map<String, dynamic>> _$LogToSupabase(Log instance,
    {required SupabaseProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return {
    'date': instance.date.toIso8601String(),
    'weight': instance.weight,
    'height': instance.height,
    'squat': instance.squat,
    'pull_up': instance.pullUp,
    'bench_press': instance.benchPress,
    'deadlift': instance.deadlift,
    'distance': instance.distance,
    'time_running': instance.timeRunning,
    'id': instance.id
  };
}

Future<Log> _$LogFromSqlite(Map<String, dynamic> data,
    {required SqliteProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return Log(
      date: DateTime.parse(data['date'] as String),
      weight: data['weight'] as double,
      height: data['height'] as double,
      squat: data['squat'] as double,
      pullUp: data['pull_up'] as double,
      benchPress: data['bench_press'] as double,
      deadlift: data['deadlift'] as double,
      distance: data['distance'] as double,
      timeRunning: data['time_running'] as double,
      id: data['id'] as String)
    ..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$LogToSqlite(Log instance,
    {required SqliteProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return {
    'date': instance.date.toIso8601String(),
    'weight': instance.weight,
    'height': instance.height,
    'squat': instance.squat,
    'pull_up': instance.pullUp,
    'bench_press': instance.benchPress,
    'deadlift': instance.deadlift,
    'distance': instance.distance,
    'time_running': instance.timeRunning,
    'id': instance.id
  };
}

/// Construct a [Log]
class LogAdapter extends OfflineFirstWithSupabaseAdapter<Log> {
  LogAdapter();

  @override
  final supabaseTableName = 'logs';
  @override
  final defaultToNull = true;
  @override
  final fieldsToSupabaseColumns = {
    'date': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'date',
    ),
    'weight': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'weight',
    ),
    'height': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'height',
    ),
    'squat': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'squat',
    ),
    'pullUp': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'pull_up',
    ),
    'benchPress': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'bench_press',
    ),
    'deadlift': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'deadlift',
    ),
    'distance': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'distance',
    ),
    'timeRunning': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'time_running',
    ),
    'id': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'id',
    )
  };
  @override
  final ignoreDuplicates = false;
  @override
  final uniqueFields = {'id'};
  @override
  final Map<String, RuntimeSqliteColumnDefinition> fieldsToSqliteColumns = {
    'primaryKey': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: '_brick_id',
      iterable: false,
      type: int,
    ),
    'date': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'date',
      iterable: false,
      type: DateTime,
    ),
    'weight': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'weight',
      iterable: false,
      type: double,
    ),
    'height': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'height',
      iterable: false,
      type: double,
    ),
    'squat': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'squat',
      iterable: false,
      type: double,
    ),
    'pullUp': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'pull_up',
      iterable: false,
      type: double,
    ),
    'benchPress': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'bench_press',
      iterable: false,
      type: double,
    ),
    'deadlift': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'deadlift',
      iterable: false,
      type: double,
    ),
    'distance': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'distance',
      iterable: false,
      type: double,
    ),
    'timeRunning': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'time_running',
      iterable: false,
      type: double,
    ),
    'id': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'id',
      iterable: false,
      type: String,
    )
  };
  @override
  Future<int?> primaryKeyByUniqueColumns(
      Log instance, DatabaseExecutor executor) async {
    final results = await executor.rawQuery('''
        SELECT * FROM `Log` WHERE id = ? LIMIT 1''', [instance.id]);

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'Log';

  @override
  Future<Log> fromSupabase(Map<String, dynamic> input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$LogFromSupabase(input,
          provider: provider, repository: repository);
  @override
  Future<Map<String, dynamic>> toSupabase(Log input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$LogToSupabase(input, provider: provider, repository: repository);
  @override
  Future<Log> fromSqlite(Map<String, dynamic> input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$LogFromSqlite(input, provider: provider, repository: repository);
  @override
  Future<Map<String, dynamic>> toSqlite(Log input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$LogToSqlite(input, provider: provider, repository: repository);
}
