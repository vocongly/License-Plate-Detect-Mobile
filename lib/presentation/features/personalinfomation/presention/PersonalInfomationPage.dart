// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/models/User.dart';
import 'package:license_plate_detect/core/models/vehicle_info.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/presentation/features/home/presention/HomePage.dart';
import 'package:license_plate_detect/presentation/features/personalinfomation/presention/EditProfilePage.dart';
import 'package:license_plate_detect/presentation/features/personalinfomation/widget/profile_widget.dart';
import 'package:license_plate_detect/presentation/features/personalinfomation/widget/profile_widget_local.dart';
import 'package:license_plate_detect/presentation/features/personalinfomation/widget/vehicle_item.dart';
import 'package:license_plate_detect/presentation/features/settings/presention/SettingsPage.dart';
import 'package:license_plate_detect/services/api/app_api.dart';
import 'package:license_plate_detect/services/localstorage/localStorage.dart';
import 'package:license_plate_detect/ultis/checkInternet/checkInternet.dart';

class PersonalInfomationPage extends StatefulWidget {
  const PersonalInfomationPage({super.key});

  @override
  State<PersonalInfomationPage> createState() => _PersonalInfomationPageState();
}

User userLocal = User();

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

  var isDeviceConnected = false;
  bool isAlertSet = false;

  void checkConnection() async {
    bool checkConnection =
        await checkInternet.getConnectivity(isDeviceConnected, isAlertSet);
    if (!checkConnection) {
      checkInternet.showDialogBox(context, isDeviceConnected, isAlertSet);
      setState(
        () => isAlertSet = true,
      );
    }
  }

  @override
  void initState() {
    checkConnection();
    setState(() {
      userLocal = LocalStorage.getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          children: [
          Center(
              child: userLocal.avatar != null
                  ? ProfileWidget(
                      imagePath: userLocal.avatar!,
                      onNavigator: (() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProfilePage();
                        }));
                      }),
                      onClicked: () {})
                  : ProfileWidgetLocal(
                      imagePath: "assets/avata_default.jpg",
                      onNavigator: (() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProfilePage();
                        }));
                      }),
                      onClicked: () {})),
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildName(userLocal),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Danh sách xe đăng ký',
                    style: Theme.of(context).textTheme.headlineSmall!),
                SizedBox(
                  height: 12,
                ),
                FutureBuilder(
                  future: AppAPI.vehicleByUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      List<VehicleInfo> vehicles = snapshot.data;
                      return vehicles.isNotEmpty
                          ? SizedBox(
                              height: 80 * vehicles.length.toDouble(),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: vehicles.length,
                                itemBuilder: (context, index) {
                                  return VehicleItem(
                                    vehicles: vehicles,
                                    index: index,
                                  );
                                },
                              ))
                          : Text('Tài khoản chưa đăng ký xe',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal));
                    } else if (snapshot.hasError) {
                      return Text('Lỗi : ${snapshot.error}',
                          style: TextStyle(color: Colors.black, fontSize: 20));
                    }
                    return CircularProgressIndicator();
                  },
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget buildName(User user) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            user.username!,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColor.primaryColor),
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
          if (user.firstName != null && user.lastName != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.lastName! + ' ' + user.firstName!,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey),
                ),
              ],
            )
        ],
      );
}
