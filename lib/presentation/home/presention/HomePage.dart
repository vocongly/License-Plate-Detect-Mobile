// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:license_plate_detect/core/models/PlateInfo.dart';
import 'package:license_plate_detect/core/models/Token.dart';
import 'package:license_plate_detect/core/models/User.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/presentation/personalinfomation/presention/PersonalInfomationPage.dart';
import 'package:license_plate_detect/presentation/registervehicle/presention/register_moto_page.dart';
import 'package:license_plate_detect/presentation/settings/presention/SettingsPage.dart';
import 'package:license_plate_detect/services/api/app_api.dart';
import 'package:license_plate_detect/ultis/snackbar/snackbar_controller.dart';
import '../../../core/component/build_button.dart';
import '../../../services/localstorage/localStorage.dart';
import 'package:license_plate_detect/ultis/checkInternet/checkInternet.dart';

import '../widgets/avatar_and_inform.dart';
import '../widgets/hello_ask.dart';
import '../widgets/signup_vehicle.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool loading = true;

Image img = Image.asset("assets/0000_02187_b.jpg");

Token tokenLocal = Token();
User userLocal = User();

class _MyHomePageState extends State<MyHomePage> {
  File? image;

  int _selectedIndex = 0;

  Future pickImage(ImageSource source) async {
    try {
      final imagepost = await ImagePicker().pickImage(source: source);
      if (imagepost == null) return;
      final imageTemporary = File(imagepost.path);

      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const PersonalInfomationPage();
      }));
    }

    if (index == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const SettingsPage();
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
    tokenLocal = LocalStorage.getToken();
    userLocal = LocalStorage.getUser();

    checkConnection();
    super.initState();
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarandInform(
                  imagePath: userLocal.avatar,
                  onClickedBell: () {
                    SnackBarController().show(
                        context: context, content: "Tính năng đang phát triển");
                  },
                  onClickedAvata: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const PersonalInfomationPage();
                    }));
                  },
                ),
                Hello(
                  username: userLocal.firstName,
                ),
                const SizedBox(
                  height: 24,
                ),
                SignunVehicle(
                  onClicked: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegisterVehiclePage();
                    }));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Truy vấn biển số theo hình ảnh',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Center(
                        child: Image.file(
                      image!,
                      height: 250,
                      width: 250,
                      fit: BoxFit.fill,
                    )),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    BuildButton(
                        title: 'Pick Gallery',
                        icon: Icons.image_outlined,
                        onClicked: () => pickImage(ImageSource.gallery)),
                    const SizedBox(
                      height: 24,
                    ),
                    BuildButton(
                        title: 'Pick Camera',
                        icon: Icons.camera_alt_outlined,
                        onClicked: () => pickImage(ImageSource.camera)),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
                image != null
                    ? FutureBuilder(
                        future: AppAPI.Upload(image!),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            List<PlateInfo> plates = snapshot.data;
                            return plates.isNotEmpty
                                ? Column(
                                    //mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'Danh sách biển số xe: ' +
                                              plates.length.toString() +
                                              ' biển số xe',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontSize: 16),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 60 * plates.length.toDouble(),
                                        child: ListView.builder(
                                            itemCount: plates.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                  color: Colors.grey[400],
                                                  child: ListTile(
                                                      title: Text(
                                                    plates[index].plate!,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  )));
                                            }),
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child: Text(
                                      'Không nhận diện được !',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                          } else if (snapshot.hasError) {
                            return Text('Lỗi : ${snapshot.error}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20));
                          }
                          return const CircularProgressIndicator();
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
