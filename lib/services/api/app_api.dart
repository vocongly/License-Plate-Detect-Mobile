// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:license_plate_detect/core/models/PlateInfo.dart';
import 'package:license_plate_detect/core/models/Token.dart';
import 'package:license_plate_detect/core/models/checkAndDetail.dart';
import 'package:license_plate_detect/feature/home/presention/HomePage.dart';
import 'package:license_plate_detect/services/localstorage/localStorage.dart';
import 'package:license_plate_detect/ultis/checkInternet/checkInternet.dart';

import '../../core/models/User.dart';
import '../../core/theme/app_data.dart';

class AppAPI {

  static Future<bool> Login(String username, String password) async {
    bool check = true;
    Token token = Token();
    User user = User();
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
      user = User.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['user']);
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
    CheckAndDetail reg = CheckAndDetail();
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
    CheckAndDetail reg = CheckAndDetail();
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
    CheckAndDetail reg = CheckAndDetail();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/forget_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email}),
    );
    if (response.statusCode == 202) {
      reg.check = true;
      reg.detail =
          json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
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

  static Future<CheckAndDetail> otpResetPassword(
      String email, String otp) async {
    CheckAndDetail reg = CheckAndDetail();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/confirm_forget_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email, "otp": otp}),
    );
    if (response.statusCode == 200) {
      reg.check = true;
      reg.detail =
          json.decode(utf8.decode(response.bodyBytes))['reset_token'] as String;
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

  static Future<CheckAndDetail> resetpassword(
      String token, String password) async {
    CheckAndDetail reg = CheckAndDetail();
    final response = await http.post(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/reset_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"token": token, "password": password}),
    );
    if (response.statusCode == 202) {
      reg.check = true;
      reg.detail =
          json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
    } else {
      reg.check = false;
      reg.detail = 'Đã có lỗi xảy ra! Vui lòng thử lại';
    }
    return reg;
  }

  static Future<List<PlateInfo>> Upload(File imageFile) async {

    var postUri = Uri.parse(AppData.urlAPI + '/api/v1/license-plate-app/in_and_out/check_image');

    http.MultipartRequest request = await new http.MultipartRequest("POST", postUri);

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image', imageFile.path);

    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      List<PlateInfo> plates = [];
      var result = await response.stream.bytesToString();
      var list = json.decode(result) as List<dynamic>;
      plates = list.map((model) => PlateInfo.fromJson(model)).toList();
      return plates;
    }else if(response.statusCode == 400){
      List<PlateInfo> plates =[];
      return plates;
    } 
    else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Không nhận diện được.');
    }
  }

  static Future<CheckAndDetail> UpdateAvatar(File imageFile) async {
    CheckAndDetail cks = new CheckAndDetail();
    var postUri =
        Uri.parse(AppData.urlAPI + '/api/v1/auth/user/users/me/avatar');

    Token token = LocalStorage.getToken();

    Map<String, String> headers = {
      'Authorization': 'Bearer ${token.accessToken}'
    };

    http.MultipartRequest request =
        await new http.MultipartRequest("PUT", postUri);

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('file', imageFile.path);

    request.headers.addAll(headers);
    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      cks.detail = json.decode(result)['avatar'];
      cks.check = true;
    } else {
      cks.detail = json.decode(await response.stream.bytesToString())['detail'];
      cks.check = false;
    }
    return cks;
  }

  static Future<CheckAndDetail> updateProfile(
      String firstName, String lastName, String phoneNumber) async {
    CheckAndDetail reg = CheckAndDetail();

    Token token = LocalStorage.getToken();

    final response = await http.put(
      Uri.parse(AppData.urlAPI + '/api/v1/auth/user/users/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token.accessToken}'
      },
      body: jsonEncode({
        "phone_number": phoneNumber,
        "first_name": firstName,
        "last_name": lastName
      }),
    );

    if (response.statusCode == 200) {
      reg.check = true;
      reg.detail =
          json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
    } else if (response.statusCode == 422) {
      reg.check = false;
      reg.detail = 'Số điện thoại đã tồn tại';
    } else {
      reg.check = false;
      reg.detail = json.decode(utf8.decode(response.bodyBytes))['detail'] as String;
    }
    return reg;
  }

  
}
