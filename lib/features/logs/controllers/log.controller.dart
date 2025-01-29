import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../brick/repository.dart';
import '../models/log.model.dart';
import '../widgets/dialogs/delete_confirmation_dialog.widget.dart';
import '../widgets/dialogs/saving_dialog.widget.dart';

class LogController extends GetxController {
  LogController({this.log});

  final Log? log;
  final formKey = GlobalKey<FormState>();
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
  Duration? _timeRunning;
  DateTime _date = DateTime.now();

  @override
  void onInit() {
    _setInitialValues();
    super.onInit();
  }

  @override
  void onClose() {
    for (var controller in controllersFieldsMap.keys) {
      controller.dispose();
    }
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

  void addPhoto() {}

  void save() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    Get.dialog(SavingDialog(), barrierDismissible: false);

    await Repository().upsert<Log>(Log(
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

    await Future.delayed(Duration(milliseconds: 100));

    Get.back();
    Get.back();
  }

  void delete() async {
    if (log == null) return;

    final deletionWasConfirmed =
        await Get.dialog<bool>(DeleteConfirmationDialog());

    if (deletionWasConfirmed != null && deletionWasConfirmed) {
      Repository().delete(log!);
      Get.back();
    }
  }

  void _setInitialValues() {
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
}
