import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/core/theme/app_theme.dart';
import 'presentation/login/presention/LoginPage.dart';
import 'presentation/home/presention/HomePage.dart';
import 'services/auth/auth.dart';

void main() async {
  await Hive.initFlutter();

  var token = await Hive.openBox('token');

  var user = await Hive.openBox('user');

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
        //home: LoginPage());
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
        //home: RegisterVehiclePage());
  }
}
