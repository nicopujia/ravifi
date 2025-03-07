import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/log.controller.dart';

class DecimalFormField extends StatelessWidget {
  const DecimalFormField({
    super.key,
    required this.hintText,
    this.textEditingController,
  });

  final String hintText;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LogController>();
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      decoration: InputDecoration.collapsed(hintText: hintText),
      textInputAction: TextInputAction.next,
      validator: controller.validateDecimal,
      autofocus: controller.log == null,
      controller: textEditingController,
    );
  }
}
