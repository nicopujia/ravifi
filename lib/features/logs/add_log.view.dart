import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ravifi/features/logs/add_log.controller.dart';

import 'widgets/aerobics_fields.dart';
import 'widgets/bmi_fields.dart';
import 'widgets/date_field.dart';
import 'widgets/field_set.dart';
import 'widgets/strength_fields.dart';

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
            DateField(),
            SizedBox(height: 16),
            FieldSet(
              labelText: 'BMI',
              icon: Icons.boy,
              children: [
                Row(
                  children: [
                    Expanded(child: WeightField()),
                    Expanded(child: HeightField()),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            FieldSet(
              labelText: 'Strength',
              icon: Icons.fitness_center,
              children: [
                StrengthFieldSetHint(),
                Row(
                  children: [
                    Expanded(child: SquatField()),
                    Expanded(child: BenchPressField()),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: PullUpsField()),
                    Expanded(child: DeadliftField()),
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
                    Expanded(child: DistanceField()),
                    Expanded(child: TimeRunningField()),
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
