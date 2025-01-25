import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLogController extends GetxController {
  Duration? timeRunning;
  final timeRunningController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? validateDecimal(String? value) {
    if (value == null || value.isEmpty) return null;
    final valueNumeric = double.tryParse(value.replaceAll(RegExp(','), '.'));
    if (valueNumeric == null) return 'Invalid decimal number.';
    if (valueNumeric <= 0) return 'Must be greater than 0.';
    return null;
  }

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
