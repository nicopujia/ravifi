import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLogController extends GetxController {
  final formKey = GlobalKey<FormState>();

  void save() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      Get.back();
    }
  }

  void addPhoto() {}
}
