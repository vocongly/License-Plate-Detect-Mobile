// ignore_for_file: unrelated_type_equality_checks

import 'dart:ffi';

import 'package:license_plate_detect/core/models/Token.dart';
import 'package:license_plate_detect/core/models/checkAndDetail.dart';
import 'package:license_plate_detect/services/api/app_api.dart';
import 'package:license_plate_detect/services/localstorage/localStorage.dart';
import 'package:license_plate_detect/ultis/dialog/alertDialog.dart';

import '../../core/models/User.dart';

class Authenticate{
  static Future<bool> checkLogin() async {
    return await LocalStorage.checkToken();
  }

  static Future<bool> login(String username,String password) async {
    bool check = true;
    bool login = await checkLogin();
    if(login == false){
      check= await AppAPI.Login(username, password);
    }
    return check;
  }

  static Future<CheckAndDetail> register(String email,String username,String phonenumber,String password) async{
    CheckAndDetail reg = await AppAPI.signup(email,username,phonenumber,password);
    return reg;
  }

  static Future<CheckAndDetail> otp(String email,String otp) async{
    CheckAndDetail reg = await AppAPI.otp(email, otp);
    return reg;
  }

  static Future<CheckAndDetail> forgotpassword(String email) async{
    CheckAndDetail reg = await AppAPI.forgotpassword(email);
    return reg;
  }

  static Future<CheckAndDetail> otpResetPassword(String email,String otp) async{
    CheckAndDetail reg = await AppAPI.otpResetPassword(email, otp);
    return reg;
  }

    static Future<CheckAndDetail> resetPassword(String token,String password) async{
    CheckAndDetail reg = await AppAPI.resetpassword(token, password);
    return reg;
  }

  static Future<void> logout() async {
    LocalStorage.deleteToken();
    LocalStorage.deleteUser();
  }

}