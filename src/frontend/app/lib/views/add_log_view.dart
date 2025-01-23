import 'package:flutter/material.dart';

class AddLogView extends StatefulWidget {
  const AddLogView({super.key});

  @override
  State<AddLogView> createState() => _AddLogViewState();
}

class _AddLogViewState extends State<AddLogView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add log'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            InputDatePickerFormField(
              firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              fieldLabelText: 'Date',
            ),
            SizedBox(height: 16),
            FormFieldSet(
              label: Text('BMI'),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration:
                            InputDecoration.collapsed(hintText: 'Weight'),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration:
                            InputDecoration.collapsed(hintText: 'Height'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            FormFieldSet(
              label: Text('Strength'),
              children: [
                RichText(
                  text: TextSpan(
                    text:
                        'You may specify either maximum the amount of reps you made or the maximum weight you lifted last week, but',
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
                    Expanded(
                        child: TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration.collapsed(hintText: 'Squat'),
                    )),
                    Expanded(
                        child: TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration:
                          InputDecoration.collapsed(hintText: 'Bench press'),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration:
                          InputDecoration.collapsed(hintText: 'Pull-ups'),
                    )),
                    Expanded(
                        child: TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration:
                          InputDecoration.collapsed(hintText: 'Deadlift'),
                    )),
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
                    Expanded(
                      child: TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration:
                            InputDecoration.collapsed(hintText: 'Distance'),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration.collapsed(hintText: 'Time'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              label: Text('Add photo'),
              icon: Icon(Icons.photo),
            ),
            FilledButton(
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
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
