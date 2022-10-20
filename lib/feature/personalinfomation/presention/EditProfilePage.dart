import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:license_plate_detect/core/models/checkAndDetail.dart';
import 'package:license_plate_detect/feature/personalinfomation/presention/PersonalInfomationPage.dart';
import 'package:license_plate_detect/feature/personalinfomation/widget/button_widget.dart';
import 'package:license_plate_detect/feature/personalinfomation/widget/profile_widget.dart';
import 'package:license_plate_detect/services/auth/auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:license_plate_detect/services/localstorage/localStorage.dart';
import 'package:license_plate_detect/ultis/checkInternet/checkInternet.dart';

import '../../../core/models/User.dart';
import '../../../core/theme/app_color.dart';
import '../../../ultis/loading/loading.dart';
import '../../../ultis/toast/toast.dart';
import '../widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

File? image;

class _EditProfilePageState extends State<EditProfilePage> {
  User user = LocalStorage.getUser();

  var isDeviceConnected = false;
  bool isAlertSet = false;

  Future pickImage(ImageSource source) async {
    try {
      final imagepost = await ImagePicker().pickImage(source: source);
      if (imagepost == null) return;
      final imageTemporary = File(imagepost!.path);

      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image : $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    //print(user.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          ProfileWidget(
              imagePath: user.avatar!,
              isEdit: true,
              onNavigator: () {},
              onClicked: () async {
                await showAlertChooseImage(context);
              }),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 24,
          ),
          TextFieldWidget(
              label: 'Tên',
              text: user.firstName!,
              onChanged: (value) {
                user.firstName = value;
              }),
          SizedBox(
            height: 24,
          ),
          TextFieldWidget(
              label: 'Họ',
              text: user.lastName!,
              onChanged: (value) {
                user.lastName = value;
              }),
          SizedBox(
            height: 24,
          ),
          TextFieldWidget(
              label: 'Số điện thoại',
              text: user.phoneNumber!,
              onChanged: (value) {
                user.phoneNumber = value;
              }),
          SizedBox(
            height: 24,
          ),
          Center(
            child: ButtonWidget(
                text: 'Cập nhật thông tin',
                onClicked: () async {

                  bool checkConnection = await checkInternet.getConnectivity(isDeviceConnected, isAlertSet);
                  if (!checkConnection) {
                    checkInternet.showDialogBox(
                        context, isDeviceConnected, isAlertSet);
                    setState(
                      () => isAlertSet = true,
                    );
                  } else {
                    CheckAndDetail cks = await Authenticate.updateProfile(
                        user.firstName!, user.lastName!, user.phoneNumber!);
                    Loading.loadingtext(context, 'Đang cập nhật thông tin');
                    if (cks.check == true) {
                      Loading.dismisloading(context);
                      Toast.presentSuccessToast(context, 'Cập nhật thông tin thành công!');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PersonalInfomationPage();
                      }));
                      LocalStorage.deleteUser();
                      LocalStorage.writeUser(user);
                    } else if (cks.check == false) {
                      Loading.dismisloading(context);
                      Toast.presentErrorToast(
                          context, cks.detail);
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
            title: Text('Chọn chức năng'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Center(
                      child: TextButton(
                    onPressed: () async {
                      await pickandupdateimage(context, ImageSource.gallery);
                    },
                    child: Text(
                      'Trong máy',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
                  Center(
                      child: TextButton(
                    onPressed: () async {
                      await pickandupdateimage(context, ImageSource.camera);
                    },
                    child: Text('Máy ảnh', style: TextStyle(fontSize: 20)),
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
          Toast.presentSuccessToast(context, 'Cập nhật thành công');
          setState(() {
            user.avatar = cks.detail;
          });
        } else {
          Toast.presentErrorToast(context, '${cks.detail}');
        }
      }
    } else {
      Navigator.of(context).pop();
      Toast.presentWarningToast(context, 'Bạn chưa chọn hình');
    }
  }
}
