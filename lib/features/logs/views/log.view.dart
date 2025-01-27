import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/log.controller.dart';
import '../models/log.model.dart';
import '../widgets/decimal_form_field.widget.dart';
import '../widgets/field_set.widget.dart';

class LogView extends StatelessWidget {
  const LogView({super.key, this.log});

  final Log? log;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogController(log: log));
    return Scaffold(
      appBar: AppBar(
        title: Text('${log == null ? 'Add' : 'Edit'} log'),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            FieldSet(
              labelText: 'Date',
              icon: Icons.calendar_today,
              children: [
                TextFormField(
                  controller: controller.dateController,
                  readOnly: true,
                  onTap: controller.showDatePickerDialog,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Tap to edit',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            FieldSet(
              labelText: 'BMI',
              icon: Icons.boy,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DecimalFormField(
                        hintText: 'Weight',
                        textEditingController: controller.weightController,
                      ),
                    ),
                    Expanded(
                      child: DecimalFormField(
                        hintText: 'Height',
                        textEditingController: controller.heightController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            FieldSet(
              labelText: 'Strength',
              icon: Icons.fitness_center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DecimalFormField(
                        hintText: 'Squat',
                        textEditingController: controller.squatController,
                      ),
                    ),
                    Expanded(
                      child: DecimalFormField(
                        hintText: 'Bench press',
                        textEditingController: controller.benchPressController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DecimalFormField(
                        hintText: 'Pull-up',
                        textEditingController: controller.pullUpController,
                      ),
                    ),
                    Expanded(
                      child: DecimalFormField(
                        hintText: 'Deadlift',
                        textEditingController: controller.deadliftController,
                      ),
                    ),
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
                    Expanded(
                      child: DecimalFormField(
                        hintText: 'Distance',
                        textEditingController: controller.distanceController,
                      ),
                    ),
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
            if (log != null)
              FilledButton.tonal(
                onPressed: controller.delete,
                child: Text('Delete'),
              ),
            FilledButton(
              onPressed: controller.save,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
