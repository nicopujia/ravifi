import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../brick/repository.dart';
import 'log.model.dart';
import 'widgets/loading_dialog.dart';

class AddLogController extends GetxController {
  Duration? timeRunning;
  DateTime date = DateTime.now();
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

  @override
  void onInit() {
    updateDateField();
    super.onInit();
  }

  String? validateDecimal(String? value) {
    if (value == null || value.isEmpty) return null;
    final valueNumeric = double.tryParse(value.replaceAll(RegExp(','), '.'));
    if (valueNumeric == null) return 'Invalid decimal number.';
    if (valueNumeric <= 0) return 'Must be greater than 0.';
    return null;
  }

  void showDatePickerDialog() async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
      lastDate: DateTime.now(),
      initialDate: date,
    );
    if (pickedDate == null) return;
    date = pickedDate;
    updateDateField();
  }

  void updateDateField() =>
      dateController.text = DateFormat.yMMMMd().format(date);

  void showTimeRunningPicker() async {
    timeRunning = await showDurationPicker(
      context: Get.context!,
      initialTime: Duration.zero,
    );
    if (timeRunning != null) {
      timeRunningController.text =
          '${timeRunning!.inHours} h ${timeRunning!.inMinutes} min';
    }
  }

  void addPhoto() {}

  void save() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    Get.dialog(LoadingDialog(), barrierDismissible: false);

    final weight = parseDecimalField(weightController);
    final height = parseDecimalField(heightController);
    final squats = parseDecimalField(squatController);
    final benchPress = parseDecimalField(benchPressController);
    final pullUps = parseDecimalField(pullUpController);
    final deadlift = parseDecimalField(deadliftController);
    final distance = parseDecimalField(distanceController);

    await Repository().upsert<Log>(Log(
      date: date,
      weight: weight,
      height: height,
      squat: squats,
      pullUp: pullUps,
      benchPress: benchPress,
      deadlift: deadlift,
      distance: distance,
      timeRunning: timeRunning?.inMinutes,
    ));

    await Future.delayed(Duration(milliseconds: 250));

    Get.back();
    Get.back();
  }

  double? parseDecimalField(TextEditingController controller) {
    var value = double.tryParse(controller.text.replaceAll(RegExp(','), '.'));
    if (value == null) return null;
    return value + .0;
  }
}
