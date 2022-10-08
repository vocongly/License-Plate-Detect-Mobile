// ignore_for_file: unrelated_type_equality_checks

import 'dart:ffi';

import 'package:license_plate_detect/core/models/Token.dart';
import 'package:license_plate_detect/core/models/register.dart';
import 'package:license_plate_detect/services/api/app_api.dart';
import 'package:license_plate_detect/services/localstorage/localStorage.dart';

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

  static Future<Register> register(String email,String username,String phonenumber,String password) async{
    Register reg = await AppAPI.signup(email,username,phonenumber,password);
    return reg;
  }
  //static Future<Array<bool,Token>> signUp()

  static Future<void> logout() async {
    LocalStorage.deleteToken();
    LocalStorage.deleteUser();
  }

}