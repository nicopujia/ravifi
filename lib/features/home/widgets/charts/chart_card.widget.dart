import 'package:flutter/material.dart';

import '../subheading.widget.dart';

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
            padding: const EdgeInsets.all(8.0),
            child: Subheading(labelText),
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
