// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/models/checkAndDetail.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/presentation/features/otpresetpassword/presention/OTPResetPassword.dart';
import 'package:license_plate_detect/presentation/widget/app_text_field.dart';
import 'package:license_plate_detect/services/auth/auth.dart';
import 'package:license_plate_detect/ultis/checkInternet/checkInternet.dart';
import 'package:license_plate_detect/ultis/toast/customtoast.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  TextEditingController emailController = TextEditingController();

  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
            left: 24,
            right: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                width: size.width,
                height: 300,
                fit: BoxFit.contain,
                image: const AssetImage("assets/img_forgot_password.png"),
              ),
              Text(
                'Quên\nMật khẩu',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Đừng lo lắng! Vui lòng nhập email liên quan đến tài khoản của bạn",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey),
                ),
              ),
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: AppTextFields(
                  controller: emailController,
                  prefix: const Icon(Icons.alternate_email_rounded),
                  hint: "Địa chỉ email",
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(
                width: size.width,
                height: 64,
                child: ElevatedButton(
                  onPressed: () async {
                    bool checkConnection = await checkInternet.getConnectivity(
                        isDeviceConnected, isAlertSet);
                    if (!checkConnection) {
                      checkInternet.showDialogBox(
                          context, isDeviceConnected, isAlertSet);
                      setState(() {
                        isAlertSet = true;
                      });
                    }else if(emailController.text == ''){
                      CustomToast.presentWarningToast(context, 'Không được để trống email!');
                    }else{
                      CheckAndDetail cks = await Authenticate.forgotpassword(emailController.text);
                      if(cks.check == true){
                        Timer(const Duration(milliseconds: 100), () {
                          CustomToast.presentSuccessToast(context,cks.detail);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OTPResetPasswordPage(email: emailController.text,);
                          }));
                        });
                      }else{
                        CustomToast.presentErrorToast(context,cks.detail);
                      }
                    }
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: const Text('Xác nhận',),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
