import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logs/views/add_log.view.dart';
import '../controllers/home.controller.dart';
import '../widgets/log_tile.widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
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
            : ListView.builder(
                itemBuilder: (_, i) => LogTile(log: controller.logs[i]),
                itemCount: controller.logs.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddLogView()),
        child: Icon(Icons.add),
      ),
    );
  }
}
