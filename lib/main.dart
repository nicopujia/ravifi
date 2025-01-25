import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'brick/repository.dart';
import 'features/home/home.view.dart';
import 'features/settings/settings.view.dart';

Future<void> main() async {
  sqfliteFfiInit();
  await Repository.configure(databaseFactory);
  await Repository().initialize();
  runApp(const MainApp());
}

class MainController extends GetxController {
  var currentPageIndex = 0.obs;

  @override
  void onInit() {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      Supabase.instance.client.auth.signInAnonymously();
    }
    super.onInit();
  }

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
