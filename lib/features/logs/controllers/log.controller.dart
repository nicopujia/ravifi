import 'dart:async';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../brick/repository.dart';
import '../models/log.model.dart';
import '../widgets/dialogs/delete_confirmation_dialog.widget.dart';
import '../widgets/dialogs/saving_dialog.widget.dart';

class LogController extends GetxController {
  LogController({this.log});

  final Log? log;
  final formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();
  final dateController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final squatController = TextEditingController();
  final benchPressController = TextEditingController();
  final pullUpController = TextEditingController();
  final deadliftController = TextEditingController();
  final distanceController = TextEditingController();
  final timeRunningController = TextEditingController();
  late final controllersFieldsMap = {
    weightController: log?.weight,
    heightController: log?.height,
    squatController: log?.squat,
    benchPressController: log?.benchPress,
    pullUpController: log?.pullUp,
    deadliftController: log?.deadlift,
    distanceController: log?.distance,
    timeRunningController: log?.timeRunning,
  };
  late final StreamSubscription _photoStreamSubscription;
  Rx<Uint8List?> photo = Rx(null);
  bool _photoHasBeenUpdated = false;
  Duration? _timeRunning;
  DateTime _date = DateTime.now();

  @override
  void onInit() async {
    _photoStreamSubscription = photo.listen((_) => _photoHasBeenUpdated = true);
    await _setInitialFormValues();
    super.onInit();
  }

  @override
  void onClose() async {
    for (var controller in controllersFieldsMap.keys) {
      controller.dispose();
    }
    await _photoStreamSubscription.cancel();
    super.onClose();
  }

  void showDatePickerDialog() async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
      lastDate: DateTime.now(),
      initialDate: _date,
    );
    if (pickedDate == null) return;
    _date = pickedDate;
    _updateDateField();
  }

  String? validateDecimal(String? value) {
    if (value == null || value.isEmpty) return null;
    final valueNumeric = double.tryParse(value.replaceAll(RegExp(','), '.'));
    if (valueNumeric == null) return 'Invalid decimal number.';
    if (valueNumeric <= 0) return 'Must be greater than 0.';
    return null;
  }

  void showTimeRunningPicker() async {
    _timeRunning = await showDurationPicker(
      context: Get.context!,
      initialTime: Duration.zero,
    );
    if (_timeRunning != null) {
      _updateTimeRunningField();
    }
  }

  void addPhotoWithCamera() => _addPhoto(ImageSource.camera);

  void addPhotoFromGallery() => _addPhoto(ImageSource.gallery);

  void removePhoto() => photo.value = null;

  void save() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    Get.dialog(SavingDialog(), barrierDismissible: false);

    final upsertedLog = await Repository().upsert<Log>(Log(
      id: log?.id,
      date: _date,
      weight: _parseDecimalField(weightController),
      height: _parseDecimalField(heightController),
      squat: _parseDecimalField(squatController),
      pullUp: _parseDecimalField(pullUpController),
      benchPress: _parseDecimalField(benchPressController),
      deadlift: _parseDecimalField(deadliftController),
      distance: _parseDecimalField(distanceController),
      timeRunning: _timeRunning?.inMinutes,
    ));
    final couldSavePhoto = await _savePhoto(upsertedLog);

    Get.back(); // Saving dialog

    if (couldSavePhoto == null || couldSavePhoto == true) {
      Get.back(); // Log view
    }
  }

  void delete() async {
    if (log == null) return;

    final deletionWasConfirmed = await Get.dialog<bool>(
      DeleteConfirmationDialog(),
    );

    if (deletionWasConfirmed == true) {
      await Repository().delete(log!);
      Get.back();
    }
  }

  Future<void> _setInitialFormValues() async {
    if (log != null) {
      _date = log!.date;
      controllersFieldsMap.forEach((controller, field) {
        if (field != null) {
          controller.text = field.toString();
        }
      });
      if (log!.timeRunning != null) {
        _timeRunning = Duration(minutes: log!.timeRunning!);
        _updateTimeRunningField();
      }
      await _loadPhoto();
    }
    _updateDateField();
  }

  void _updateDateField() {
    dateController.text = DateFormat.yMMMMEEEEd().format(_date);
  }

  void _updateTimeRunningField() {
    timeRunningController.text =
        '${_timeRunning!.inHours} h ${_timeRunning!.inMinutes % 60} min';
  }

  double? _parseDecimalField(TextEditingController controller) {
    final value = double.tryParse(controller.text.replaceAll(RegExp(','), '.'));
    if (value == null) return null;
    return (value * 10).roundToDouble() / 10;
  }

  Future<void> _loadPhoto() async {
    final file = log!.getPhotoFile();
    photo.value = await file.exists() ? await file.readAsBytes() : null;
  }

  Future<void> _addPhoto(ImageSource source) async {
    try {
      await _pickPhoto(source);
    } on PlatformException catch (error) {
      _showMsg(error.code == 'camera_access_denied'
          ? 'Allow the camera to take photos from the app.'
          : error.message ?? error.toString());
    } catch (error) {
      _showMsg('Error: $error');
    } finally {
      if (Get.isBottomSheetOpen == true) {
        Get.back();
      }
    }
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final pickedPhoto = await imagePicker.pickImage(
      source: source,
      maxWidth: 1080,
      maxHeight: 1920,
    );

    if (pickedPhoto != null) {
      photo.value = await pickedPhoto.readAsBytes();
    }
  }

  Future<bool?> _savePhoto(Log upsertedLog) async {
    if (!_photoHasBeenUpdated) return null;
    if (photo.value == null) {
      await upsertedLog.deletePhoto();
      return true;
    }
    try {
      await upsertedLog.savePhoto(photo.value!);
      return true;
    } on ImageException catch (error) {
      _showMsg(error.message);
    }
    return false;
  }

  void _showMsg(String errorMsg) {
    final messenger = ScaffoldMessenger.of(Get.context!);
    messenger.showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'OK',
          onPressed: () => messenger.hideCurrentSnackBar(
            reason: SnackBarClosedReason.action,
          ),
        ),
        content: Text(errorMsg),
      ),
    );
  }
}
