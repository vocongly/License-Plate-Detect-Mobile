import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:license_plate_detect/feature/login/presention/LoginPage.dart';
import '/core/theme/app_theme.dart';

void main() async {

  await Hive.initFlutter();

  var token = await Hive.openBox('token');

  var user = await Hive.openBox('user');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "License Plate Detect",
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      home: LoginPage(),
    );
  }
}

