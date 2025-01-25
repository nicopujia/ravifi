import 'package:flutter/material.dart';

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
