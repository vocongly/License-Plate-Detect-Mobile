// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/presentation/home/presention/HomePage.dart';
import 'package:license_plate_detect/presentation/login/presention/LoginPage.dart';
import 'package:license_plate_detect/presentation/personalinfomation/presention/PersonalInfomationPage.dart';
import 'package:license_plate_detect/presentation/settings/widgets/button_setting.dart';
import 'package:license_plate_detect/services/auth/auth.dart';
import 'package:license_plate_detect/ultis/snackbar/snackbar_controller.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 24),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chung',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor),
                ),
                SizedBox(
                  height: 12,
                ),
                buttonSetting(
                  icon: Icons.language_outlined,
                  title: 'Ngôn ngữ',
                  onClicked: () {
                    SnackBarController().show(
                        content: "Tính năng đang phát triển", context: context);
                  },
                ),
                buttonSetting(
                  icon: Icons.light_mode,
                  title: 'Chế độ sáng/tối',
                  onClicked: () {
                    SnackBarController().show(
                        content: "Tính năng đang phát triển", context: context);
                  },
                ),
                buttonSetting(
                  icon: Icons.logout_outlined,
                  title: 'Đăng xuất',
                  onClicked: () async {
                    await Authenticate.logout();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                ),
                buttonSetting(
                  icon: Icons.delete_outline,
                  title: 'Xóa tài khoản',
                  onClicked: () {
                    SnackBarController().show(
                        content: "Tính năng đang phát triển", context: context);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phản hồi',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor),
                ),
                SizedBox(
                  height: 12,
                ),
                buttonSetting(
                  icon: Icons.warning_amber_outlined,
                  title: 'Báo cáo lỗi',
                  onClicked: () {
                    SnackBarController().show(
                        content: "Tính năng đang phát triển", context: context);
                  },
                ),
                buttonSetting(
                  icon: Icons.feedback_outlined,
                  title: 'Gửi phản hồi',
                  onClicked: () {
                    SnackBarController().show(
                        content: "Tính năng đang phát triển", context: context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
