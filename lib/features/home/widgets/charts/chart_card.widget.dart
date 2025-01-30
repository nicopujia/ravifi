import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({super.key, required this.labelText, required this.chart});

  final Widget chart;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AspectRatio(aspectRatio: 16 / 9, child: chart),
          ),
        ],
      ),
    );
  }
}
