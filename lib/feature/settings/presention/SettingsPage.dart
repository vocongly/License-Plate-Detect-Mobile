import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/component/build_button.dart';

import '../../../core/theme/app_color.dart';
import '../../../pages/HomePage.dart';
import '../../../services/auth/auth.dart';
import '../../login/presention/LoginPage.dart';
import '../../personalinfomation/presention/PersonalInfomationPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyHomePage();
      }));
    }

    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return PersonalInfomationPage();
      }));
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Thông tin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColor.primaryColor,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildButton(
            title: 'Đăng xuất',
            icon: Icons.logout_outlined,
            onClicked: () {
              Authenticate.logout();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
          )
        ],
      )),
    );
  }
}
