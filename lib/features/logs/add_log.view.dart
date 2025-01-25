import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ravifi/features/logs/add_log.controller.dart';

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
            FormFieldSet(
              label: Text('BMI'),
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
            FormFieldSet(
              label: Text('Strength'),
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
            FormFieldSet(
              label: Text('Aerobics'),
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

class DateField extends StatelessWidget {
  const DateField({super.key});

  @override
  Widget build(BuildContext context) {
    return InputDatePickerFormField(
      firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      fieldLabelText: 'Date',
    );
  }
}

class StrengthFieldSetHint extends StatelessWidget {
  const StrengthFieldSetHint({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'You may specify either maximum the amount of reps you'
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

class DeadliftField extends StatelessWidget {
  const DeadliftField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(
        hintText: 'Deadlift',
      ),
    );
  }
}

class PullUpsField extends StatelessWidget {
  const PullUpsField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(
        hintText: 'Pull-ups',
      ),
    );
  }
}

class BenchPressField extends StatelessWidget {
  const BenchPressField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(
        hintText: 'Bench press',
      ),
    );
  }
}

class SquatField extends StatelessWidget {
  const SquatField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(hintText: 'Squat'),
    );
  }
}

class HeightField extends StatelessWidget {
  const HeightField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(
        hintText: 'Height',
      ),
    );
  }
}

class WeightField extends StatelessWidget {
  const WeightField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration.collapsed(
        hintText: 'Weight',
      ),
      textInputAction: TextInputAction.next,
    );
  }
}

class FormFieldSet extends StatelessWidget {
  const FormFieldSet({super.key, this.children = const [], this.label});

  final List<Widget> children;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(border: OutlineInputBorder(), label: label),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: children,
      ),
    );
  }
}
