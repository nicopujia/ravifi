import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logs/views/log.view.dart';
import '../../settings/views/settings.view.dart';
import '../widgets/log_list.widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: LogList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => LogView()),
        child: Icon(Icons.add),
      ),
    );
  }
}
