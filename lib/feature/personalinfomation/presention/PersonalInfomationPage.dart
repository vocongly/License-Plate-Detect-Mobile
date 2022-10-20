// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/component/app_text_field.dart';
import 'package:license_plate_detect/core/component/build_button.dart';
import 'package:license_plate_detect/feature/personalinfomation/presention/EditProfilePage.dart';
import 'package:license_plate_detect/feature/personalinfomation/widget/profile_widget.dart';
import 'package:license_plate_detect/feature/settings/presention/SettingsPage.dart';
import 'package:license_plate_detect/pages/HomePage.dart';

import '../../../core/models/User.dart';
import '../../../core/theme/app_color.dart';
import '../../../services/localstorage/localStorage.dart';
import '../widget/button_widget.dart';

class PersonalInfomationPage extends StatefulWidget {
  const PersonalInfomationPage({super.key});

  @override
  State<PersonalInfomationPage> createState() => _PersonalInfomationPageState();
}

User userLocal = new User();

class _PersonalInfomationPageState extends State<PersonalInfomationPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyHomePage();
      }));
    }

    if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return SettingsPage();
      }));
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    userLocal = LocalStorage.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.primarySwatch[50],
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
        child: Column(children: [
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  'My Profile',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            height: size.height * 0.4,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: LayoutBuilder(builder: (context, constraints) {
              double innerHeight = constraints.maxHeight;
              double innerWidth = constraints.maxWidth;
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: innerHeight * 0.65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[200]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          buildName(userLocal),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                        child: ProfileWidget(
                            imagePath: userLocal.avatar != null
                                ? userLocal.avatar!
                                : "assets/avata_default.jpg",
                            onNavigator: (() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditProfilePage();
                              }));
                            }),
                            onClicked: () {})),
                  )
                ],
              );
            }),
          ),
          SizedBox(
            height: 24,
          ),
        ]),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.username!,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            user.email!,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.grey),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            user.phoneNumber!,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.grey),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'first name: ',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
              Text(user.firstName! != null ? user.firstName! : ' ')
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'last name: ',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
              ),
              Text(user.lastName! != null ? user.lastName! : ' ')
            ],
          ),
        ],
      );
}
