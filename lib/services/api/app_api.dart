import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:license_plate_detect/core/models/Token.dart';
import 'package:license_plate_detect/core/models/checkAndDetail.dart';
import 'package:license_plate_detect/services/localstorage/localStorage.dart';

import '../../core/models/User.dart';
import '../../core/theme/app_data.dart';

class AppAPI {
  static Future<bool> Login(String username, String password) async {
    bool check = true;
    Token token = new Token();
    User user = new User();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      // var list = json.decode(utf8.decode(response.bodyBytes)) as Token;
      // Token token = Token.fromJson(list);
      token = Token.fromJson(jsonDecode(response.body));
      user = User.fromJson(jsonDecode(response.body)['user']);
      LocalStorage.writeToken(token.accessToken, token.tokenType);
      LocalStorage.writeUser(user);
    } else if (response.statusCode == 401) {
      // // If the server did not return a 201 CREATED response,
      // // then throw an exception.
      // throw Exception('Failed to log in.');
      check = false;
    } else {
      check = false;
    }
    return check;
  }

  static Future<CheckAndDetail> signup(String email, String username,
      String phonenumber, String password) async {
    CheckAndDetail reg = new CheckAndDetail();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
        "username": username,
        "phone_number": phonenumber,
        "password": password
      }),
    );
    if (response.statusCode == 202) {
      reg.check = true;
    } else if (response.statusCode == 400) {
      // // If the server did not return a 201 CREATED response,
      // // then throw an exception.
      // throw Exception('Failed to log in.');
      reg.check = false;
      String error =
          json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
      reg.detail = error;
    } else {
      reg.check = false;
      reg.detail = 'Đã có lỗi xảy ra! Vui lòng thử lại';
    }
    return reg;
  }

  static Future<CheckAndDetail> otp(String email, String otp) async {
    CheckAndDetail reg = new CheckAndDetail();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/confirm_register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email, "otp": otp}),
    );
    if (response.statusCode == 201) {
      reg.check = true;
    } else if (response.statusCode == 404) {
      // // If the server did not return a 201 CREATED response,
      // // then throw an exception.
      // throw Exception('Failed to log in.');
      reg.check = false;
      String error =
          json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
      reg.detail = error;
    } else {
      reg.check = false;
      reg.detail = 'Đã có lỗi xảy ra! Vui lòng thử lại';
    }
    return reg;
  }

  static Future<CheckAndDetail> forgotpassword(String email) async {
    CheckAndDetail reg = new CheckAndDetail();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/forget_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email}),
    );
    if (response.statusCode == 202) {
      reg.check = true;
      reg.detail = json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
    } else if (response.statusCode == 400) {
      reg.check = false;
      String error =
          json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
      reg.detail = error;
    } else {
      reg.check = false;
      reg.detail = 'Đã có lỗi xảy ra! Vui lòng thử lại';
    }
    return reg;
  }

   static Future<CheckAndDetail> otpResetPassword(String email,String otp) async {
    CheckAndDetail reg = new CheckAndDetail();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/confirm_forget_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email,"otp":otp}),
    );
    if (response.statusCode == 200) {
      reg.check = true;
      reg.detail = json.decode(utf8.decode(response.bodyBytes))['reset_token'] as String;
    } else if (response.statusCode == 406) {
      reg.check = false;
      String error =
          json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
      reg.detail = error;
    } else {
      reg.check = false;
      reg.detail = 'Đã có lỗi xảy ra! Vui lòng thử lại';
    }
    return reg;
  }

  static Future<CheckAndDetail> resetpassword(String token, String password) async {
    CheckAndDetail reg = new CheckAndDetail();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/reset_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"token": token,"password": password}),
    );
    if (response.statusCode == 202) {
      reg.check = true;
      reg.detail = json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
    } else {
      reg.check = false;
      reg.detail = 'Đã có lỗi xảy ra! Vui lòng thử lại';
    }
    return reg;
  }
}
