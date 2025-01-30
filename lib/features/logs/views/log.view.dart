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
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: controller.photo.value == null
                    ? FilledButton.icon(
                        onPressed: () => Get.bottomSheet(
                          BottomSheet(
                            onClosing: () {},
                            builder: (context) => ListView(
                              shrinkWrap: true,
                              children: [
                                TextButton.icon(
                                  onPressed: controller.addPhotoWithCamera,
                                  label: Text('Take with camera'),
                                  icon: Icon(Icons.add_a_photo),
                                ),
                                TextButton.icon(
                                  onPressed: controller.addPhotoFromGallery,
                                  label: Text('Choose from gallery'),
                                  icon: Icon(Icons.library_add),
                                ),
                              ],
                            ),
                          ),
                        ),
                        label: Text('Add photo'),
                        icon: Icon(Icons.add_photo_alternate),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.memory(controller.photo.value!),
                          ),
                          TextButton.icon(
                            onPressed: controller.removePhoto,
                            label: Text('Remove photo'),
                            icon: Icon(Icons.remove),
                          ),
                        ],
                      ),
              ),
            ),
            ElevatedButton(
              onPressed: controller.save,
              child: Text('Save'),
            ),
            if (log != null)
              OutlinedButton(
                onPressed: controller.delete,
                child: Text('Delete'),
              ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
