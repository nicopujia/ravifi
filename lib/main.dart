import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart' show databaseFactory;
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactoryFfi, sqfliteFfiInit;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'brick/repository.dart';
import 'features/home/views/home.view.dart';

Future<void> main() async {
  if (Platform.isLinux ||
      Platform.isMacOS ||
      Platform.isWindows ||
      Platform.isFuchsia) {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  }
  await Repository.initializeSupabaseAndConfigure(databaseFactory);
  await Repository().initialize();
  final auth = Supabase.instance.client.auth;
  final session = auth.currentSession;
  if (session == null) {
    await auth.signInAnonymously();
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: HomeView(),
    );
  }
}
