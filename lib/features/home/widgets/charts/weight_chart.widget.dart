import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home.controller.dart';
import 'chart_card.widget.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return ChartCard(
      labelText: 'Weight',
      chart: Obx(
        () => LineChart(
          LineChartData(
            titlesData: controller.chartsTitlesData,
            minY: controller.minWeight.value - 5,
            maxY: controller.maxWeight.value + 5,
            maxX: controller.chartsMaxX,
            lineBarsData: [
              LineChartBarData(
                show: !controller.isLoading.value,
                spots: controller.weightChartSpots,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.cyan]
                        .map((e) => e.withAlpha(64))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
