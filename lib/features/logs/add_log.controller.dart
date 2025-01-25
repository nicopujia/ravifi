import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLogController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String? validateDecimal(String? value) {
    if (value == null || value.isEmpty) return null;
    final valueNumeric = double.tryParse(value.replaceAll(RegExp(','), '.'));
    if (valueNumeric == null) return 'Invalid decimal number.';
    if (valueNumeric <= 0) return 'Must be greater than 0.';
    return null;
  }

  void addPhoto() {}

  void save() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    Get.back();
  }
}
