import 'package:flutter/material.dart';

class SavingDialog extends StatelessWidget {
  const SavingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Saving...'),
      content: LinearProgressIndicator(),
    );
  }
}
