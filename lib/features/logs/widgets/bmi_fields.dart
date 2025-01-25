import 'package:flutter/material.dart';

class WeightField extends StatelessWidget {
  const WeightField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(
        hintText: 'Weight',
      ),
      textInputAction: TextInputAction.next,
    );
  }
}

class HeightField extends StatelessWidget {
  const HeightField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(
        hintText: 'Height',
      ),
    );
  }
}
