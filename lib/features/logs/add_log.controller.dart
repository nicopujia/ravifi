import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLogController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String? validateDecimal(String? value) {
    if (value == null || value.isEmpty) return null;

    if (double.tryParse(value.replaceAll(RegExp(','), '.')) == null) {
      return 'Invalid decimal number.';
    }

    return null;
  }

  void addPhoto() {}

  void save() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    Get.back();
  }
}
