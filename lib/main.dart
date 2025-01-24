import 'package:flutter/material.dart';
import 'package:ravifi/brick/repository.dart';
import 'package:ravifi/views/home_view.dart';
import 'package:ravifi/views/settings_view.dart';
import 'package:sqflite/sqflite.dart' show databaseFactory;

Future<void> main() async {
  await Repository.configure(databaseFactory);
  await Repository().initialize();
  if (!const bool.hasEnvironment('SUPABASE_KEY')) {
    throw Exception('SUPABASE_KEY not found in environment variables');
  }
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: [
          HomeView(),
          SettingsView(),
        ][_currentPageIndex],
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
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
