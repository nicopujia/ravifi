import 'package:flutter/material.dart';

class DistanceField extends StatelessWidget {
  const DistanceField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(
        hintText: 'Distance',
      ),
      textInputAction: TextInputAction.next,
    );
  }
}

class TimeRunningField extends StatelessWidget {
  const TimeRunningField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(hintText: 'Time running'),
    );
  }
}
