import 'package:flutter/material.dart';

class DecimalField extends StatelessWidget {
  const DecimalField({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration.collapsed(hintText: hintText),
      textInputAction: TextInputAction.next,
    );
  }
}
