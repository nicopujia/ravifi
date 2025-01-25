import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_log.controller.dart';
import 'widgets/decimal_field.dart';
import 'widgets/field_set.dart';

class AddLogView extends StatelessWidget {
  const AddLogView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddLogController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Add log'),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            InputDatePickerFormField(
              firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              fieldLabelText: 'Date',
              errorFormatText: 'Invalid date format. It should be mm/dd/yyyy',
            ),
            SizedBox(height: 16),
            FieldSet(
              labelText: 'BMI',
              icon: Icons.boy,
              children: [
                Row(
                  children: [
                    Expanded(child: DecimalField(hintText: 'Weight')),
                    Expanded(child: DecimalField(hintText: 'Height')),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            FieldSet(
              labelText: 'Strength',
              icon: Icons.fitness_center,
              children: [
                RichText(
                  text: TextSpan(
                    text:
                        'You may specify either maximum the amount of reps you'
                        ' made or the maximum weight you lifted last week, but',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: ' be consistent among all the logs',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' for each field.'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: DecimalField(hintText: 'Squat')),
                    Expanded(child: DecimalField(hintText: 'Bench press')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: DecimalField(hintText: 'Pull-ups')),
                    Expanded(child: DecimalField(hintText: 'Deadlift')),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            FieldSet(
              labelText: 'Aerobics',
              icon: Icons.run_circle_outlined,
              children: [
                Row(
                  children: [
                    Expanded(child: DecimalField(hintText: 'Distance')),
                    Expanded(
                      child: TextFormField(
                        controller: controller.timeRunningController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Time running',
                        ),
                        readOnly: true,
                        onTap: controller.showTimeRunningPicker,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: controller.addPhoto,
              label: Text('Add photo'),
              icon: Icon(Icons.photo),
            ),
            FilledButton(
              onPressed: controller.save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
