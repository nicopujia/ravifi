import 'dart:io';
import 'dart:typed_data';

import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';
import 'package:image/image.dart';
import 'package:uuid/uuid.dart';

import '../../../brick/repository.dart';

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

  File getPhotoFile() => File('${Repository.cacheDir.path}/$id.jpeg');

  Future<void> savePhoto(Uint8List photo) async {
    final image = decodeImage(photo);
    if (image == null) {
      throw ImageException('Invalid image format or corrupted file.');
    }
    await encodeJpgFile(getPhotoFile().path, image, quality: 50);
    // TODO: upload compressedPhoto to Supabase.
  }

  Future<void> deletePhoto() async {
    final file = getPhotoFile();
    if (!(await file.exists())) return;
    try {
      await file.delete();
    } on FileSystemException catch (e) {
      print('Photo of log $id could not be deleted: $e');
    }
  }
}
