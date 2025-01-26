import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../brick/repository.dart';
import '../models/log.model.dart';
import '../widgets/dialogs/saving_dialog.widget.dart';

class LogController extends GetxController {
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
  Duration? _timeRunning;
  DateTime _date = DateTime.now();

  @override
  void onInit() {
    _updateDateField();
    super.onInit();
  }

  @override
  void onClose() {
    dateController.dispose();
    weightController.dispose();
    heightController.dispose();
    squatController.dispose();
    benchPressController.dispose();
    pullUpController.dispose();
    deadliftController.dispose();
    distanceController.dispose();
    timeRunningController.dispose();
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
      timeRunningController.text =
          '${_timeRunning!.inHours} h ${_timeRunning!.inMinutes} min';
    }
  }

  void addPhoto() {}

  void save() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    Get.dialog(SavingDialog(), barrierDismissible: false);

    await Repository().upsert<Log>(Log(
      date: _date,
      weight: weight,
      height: height,
      squat: squats,
      pullUp: pullUps,
      benchPress: benchPress,
      deadlift: deadlift,
      distance: distance,
      timeRunning: _timeRunning?.inMinutes,
    ));

    await Future.delayed(Duration(milliseconds: 250));

    Get.back();
    Get.back();
  }

  void _updateDateField() {
    dateController.text = DateFormat.yMMMMd().format(_date);
  }

  double? _parseDecimalField(TextEditingController controller) {
    var value = double.tryParse(controller.text.replaceAll(RegExp(','), '.'));
    if (value == null) return null;
    return value + .0;
  }
}
