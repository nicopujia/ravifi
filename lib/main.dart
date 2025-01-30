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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
        brightness: Brightness.light,
        fontFamily: 'ChakraPetch',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(48.0)),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
        brightness: Brightness.dark,
        fontFamily: 'ChakraPetch',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: false,
        ),
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(48.0)),
          ),
        ),
      ),
      home: HomeView(),
    );
  }
}
