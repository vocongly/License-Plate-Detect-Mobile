// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:license_plate_detect/core/models/User.dart';
import 'package:license_plate_detect/core/models/checkAndDetail.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/presentation/features/personalinfomation/presention/PersonalInfomationPage.dart';
import 'package:license_plate_detect/presentation/features/personalinfomation/widget/button_widget.dart';
import 'package:license_plate_detect/presentation/features/personalinfomation/widget/profile_widget.dart';
import 'package:license_plate_detect/presentation/features/personalinfomation/widget/profile_widget_local.dart';
import 'package:license_plate_detect/services/auth/auth.dart';
import 'package:license_plate_detect/services/localstorage/localStorage.dart';
import 'package:license_plate_detect/ultis/checkInternet/checkInternet.dart';
import 'package:license_plate_detect/ultis/loading/customloading.dart';
import 'package:license_plate_detect/ultis/toast/customtoast.dart';

import '../widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

File? image;
User user = User();

class _EditProfilePageState extends State<EditProfilePage> {
  var isDeviceConnected = false;
  bool isAlertSet = false;

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

  @override
  void initState() {
    //print(user.email);
    user = LocalStorage.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const PersonalInfomationPage();
            }));
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          user.avatar != null
              ? ProfileWidget(
                  imagePath: user.avatar!,
                  isEdit: true,
                  onNavigator: () {},
                  onClicked: () async {
                    await showAlertChooseImage(context);
                  })
              : ProfileWidgetLocal(
                  imagePath: "assets/avata_default.jpg",
                  isEdit: true,
                  onNavigator: () {},
                  onClicked: () async {
                    await showAlertChooseImage(context);
                  }),
          const SizedBox(
            height: 48,
          ),
          TextFieldWidget(
              label: 'Tên',
              text: user.firstName != null ? user.firstName! : '',
              onChanged: (value) {
                user.firstName = value;
              }),
          const SizedBox(
            height: 24,
          ),
          TextFieldWidget(
              label: 'Họ',
              text: user.lastName != null ? user.lastName! : '',
              onChanged: (value) {
                user.lastName = value;
              }),
          const SizedBox(
            height: 24,
          ),
          TextFieldWidget(
              label: 'Số điện thoại',
              text: user.phoneNumber!,
              onChanged: (value) {
                user.phoneNumber = value;
              }),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: ButtonWidget(
                text: 'Cập nhật thông tin',
                onClicked: () async {
                  bool checkConnection = await checkInternet.getConnectivity(
                      isDeviceConnected, isAlertSet);
                  if (!checkConnection) {
                    checkInternet.showDialogBox(
                        context, isDeviceConnected, isAlertSet);
                    setState(
                      () => isAlertSet = true,
                    );
                  } else {
                    CheckAndDetail cks = await Authenticate.updateProfile(
                        user.firstName!, user.lastName!, user.phoneNumber!);
                    CustomLoading.loadingtext(
                        context, 'Đang cập nhật thông tin');
                    if (cks.check == true) {
                      CustomLoading.dismisloading(context);
                      CustomToast.presentSuccessToast(
                          context, 'Cập nhật thông tin thành công!');
                      //LocalStorage.deleteUser();
                      LocalStorage.writeUser(user);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PersonalInfomationPage();
                      }));
                    } else if (cks.check == false) {
                      CustomLoading.dismisloading(context);
                      CustomToast.presentErrorToast(context, cks.detail);
                    }
                  }
                }),
          )
        ],
      )),
    );
  }

  showAlertChooseImage(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Chọn chức năng'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Center(
                      child: TextButton(
                    onPressed: () async {
                      await pickandupdateimage(context, ImageSource.gallery);
                    },
                    child: const Text(
                      'Trong máy',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )),
                  Center(
                      child: TextButton(
                    onPressed: () async {
                      await pickandupdateimage(context, ImageSource.camera);
                    },
                    child: const Text('Máy ảnh',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  )),
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickandupdateimage(
      BuildContext context, ImageSource imageSource) async {
    await pickImage(imageSource);
    if (image?.path != null) {
      bool checkConnection =
          await checkInternet.getConnectivity(isDeviceConnected, isAlertSet);
      if (!checkConnection) {
        checkInternet.showDialogBox(context, isDeviceConnected, isAlertSet);
        setState(
          () => isAlertSet = true,
        );
      } else {
        CheckAndDetail cks = await Authenticate.updateImage(image!);
        if (cks.check == true) {
          Navigator.of(context).pop();
          CustomToast.presentSuccessToast(context, 'Cập nhật ảnh thành công');
          setState(() {
            user.avatar = cks.detail;
            LocalStorage.deleteUser();
            LocalStorage.writeUser(user);
          });
        } else {
          CustomToast.presentErrorToast(context, cks.detail);
        }
      }
    } else {
      Navigator.of(context).pop();
      CustomToast.presentWarningToast(context, 'Bạn chưa chọn hình');
    }
  }
}
