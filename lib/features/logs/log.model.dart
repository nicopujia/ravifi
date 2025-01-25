import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';
import 'package:uuid/uuid.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'logs'),
)
class Log extends OfflineFirstWithSupabaseModel {
  final DateTime date;
  final double? weight;
  final double? height;
  final double? squat;
  final double? pullUp;
  final double? benchPress;
  final double? deadlift;
  final double? distance;
  final int? timeRunning;

  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String id;

  Log({
    String? id,
    required this.date,
    this.weight,
    this.height,
    this.squat,
    this.pullUp,
    this.benchPress,
    this.deadlift,
    this.distance,
    this.timeRunning,
  }) : id = id ?? const Uuid().v4();
}
