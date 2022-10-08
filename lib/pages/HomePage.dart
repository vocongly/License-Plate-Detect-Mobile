// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:license_plate_detect/core/models/Token.dart';
import 'package:license_plate_detect/core/models/User.dart';
import 'package:license_plate_detect/feature/login/presention/LoginPage.dart';
import 'package:license_plate_detect/services/auth/auth.dart';
import '../services/localstorage/localStorage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool loading = true;
Token tokenLocal = new Token();
User userLocal = new User();

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    tokenLocal = LocalStorage.getToken();
    userLocal = LocalStorage.getUser();
    print('accesstoken: '+tokenLocal.accessToken!.toString());
    print('tokentype: '+tokenLocal.tokenType!.toString());
    print('id: '+userLocal.sId.toString());
    print('email: '+userLocal.email.toString());
    print('username: '+userLocal.username.toString());
    print('phone number: '+userLocal.phoneNumber.toString());
    print('firstname: '+userLocal.firstName.toString());
    print('lastname: '+userLocal.lastName.toString());
    print('avatar: '+userLocal.avatar.toString());
    super.initState();

    // //LocalStorage.writeToken(widget.token.accessToken, widget.token.tokenType);

    // print(LocalStorage.checkToken());

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(tokenLocal.accessToken!),
          ElevatedButton(
            onPressed: (){
              Authenticate.logout();
              Navigator.push(context,MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
            style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
            child: Text('Log out')),
        ],
      ),
    );
  }
}
