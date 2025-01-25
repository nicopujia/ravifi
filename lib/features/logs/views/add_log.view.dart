import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_log.controller.dart';
import '../widgets/decimal_field.widget.dart';
import '../widgets/field_set.widget.dart';

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
                      child: DecimalField(
                        hintText: 'Weight',
                        textEditingController: controller.weightController,
                      ),
                    ),
                    Expanded(
                      child: DecimalField(
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
                      child: DecimalField(
                        hintText: 'Squat',
                        textEditingController: controller.squatController,
                      ),
                    ),
                    Expanded(
                      child: DecimalField(
                        hintText: 'Bench press',
                        textEditingController: controller.benchPressController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DecimalField(
                        hintText: 'Pull-up',
                        textEditingController: controller.pullUpController,
                      ),
                    ),
                    Expanded(
                      child: DecimalField(
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
                      child: DecimalField(
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
