import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logs/views/log.view.dart';
import '../../settings/views/settings.view.dart';
import '../controllers/home.controller.dart';
import '../widgets/charts/weight_chart.widget.dart';
import '../widgets/log_list.widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Ravifi'),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => SettingsView()),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Obx(
        () => controller.logs.isEmpty
            ? Center(
                child: Text(
                  controller.isLoading.value
                      ? 'Loading...'
                      : controller.errorMsg.isEmpty
                          ? 'No logs.'
                          : 'Error: ${controller.errorMsg.value}',
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    if (controller.weightChartSpots.isNotEmpty) WeightChart(),
                    LogList(),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => LogView()),
        child: Icon(Icons.add),
      ),
    );
  }
}
