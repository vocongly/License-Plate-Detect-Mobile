// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:license_plate_detect/config/dependency/dependency_config.dart';
import 'package:license_plate_detect/core/theme/app_theme.dart';
import 'package:license_plate_detect/presentation/features/home/presention/HomePage.dart';
import 'package:license_plate_detect/presentation/features/login/presention/LoginPage.dart';
import 'package:license_plate_detect/presentation/features/notification/notification_page.dart';
import 'services/auth/auth.dart';

void main() async {
  await Hive.initFlutter();

  var token = await Hive.openBox('token');

  var user = await Hive.openBox('user');

  await configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Authenticate _auth = Authenticate();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "License Plate Detect",
        theme: AppTheme.light,
        themeMode: ThemeMode.light,
        // home: const NotificationPage());
        home: FutureBuilder(
          future: _auth.checkLogin(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const MyHomePage();
              } 
              return const LoginPage();
            }
            return const CircularProgressIndicator();
          }),
        ));
  }
}
