import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete confirmation'),
      content: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge,
          text: 'Are you sure you want to delete this log? ',
          children: [
            TextSpan(
              text: 'This action is permanent.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Get.back(result: true),
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
