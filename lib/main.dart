import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ravifi/brick/repository.dart';
import 'package:ravifi/features/home/home.view.dart';
import 'package:ravifi/features/settings/settings.view.dart';
import 'package:sqflite/sqflite.dart' show databaseFactory;

Future<void> main() async {
  await Repository.configure(databaseFactory);
  await Repository().initialize();
  if (!const bool.hasEnvironment('SUPABASE_KEY')) {
    throw Exception('SUPABASE_KEY not found in environment variables');
  }
  runApp(const MainApp());
}

class MainController extends GetxController {
  var currentPageIndex = 0.obs;

  void updatePage(int index) => currentPageIndex.value = index;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return GetMaterialApp(
      home: Obx(
        () => Scaffold(
          body: [
            HomeView(),
            SettingsView(),
          ][controller.currentPageIndex.value],
          bottomNavigationBar: NavigationBar(
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
            selectedIndex: controller.currentPageIndex.value,
            onDestinationSelected: controller.updatePage,
          ),
        ),
      ),
    );
  }
}
