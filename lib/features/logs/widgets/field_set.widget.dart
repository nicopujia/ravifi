import 'package:flutter/material.dart';

class FieldSet extends StatelessWidget {
  const FieldSet({
    super.key,
    required this.labelText,
    this.icon,
    this.children = const [],
  });

  final String labelText;
  final IconData? icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon),
            SizedBox(width: 4),
            Text(labelText),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: children,
      ),
    );
  }
}
