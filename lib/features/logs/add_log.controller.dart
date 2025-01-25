import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddLogController extends GetxController {
  Duration? timeRunning;
  DateTime date = DateTime.now();
  final timeRunningController = TextEditingController();
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

  void save() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    Get.back();
  }
}
