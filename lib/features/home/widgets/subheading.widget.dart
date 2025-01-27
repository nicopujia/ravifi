import 'package:flutter/material.dart';

class Subheading extends StatelessWidget {
  const Subheading(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
