import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:license_plate_detect/core/models/Token.dart';
import 'package:license_plate_detect/core/models/register.dart';
import 'package:license_plate_detect/services/localstorage/localStorage.dart';

import '../../core/models/User.dart';
import '../../core/theme/app_data.dart';


class AppAPI{
  static Future<bool> Login(String username,String password) async {
    bool check=true;
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
    } else if(response.statusCode == 401){
      // // If the server did not return a 201 CREATED response,
      // // then throw an exception.
      // throw Exception('Failed to log in.');
      check = false;
    }else{
      check= false;
    }
    return check;
  }

  static Future<Register> signup(String email,String username,String phonenumber,String password)async {
    Register reg = new Register();
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
    if (response.statusCode == 200) {
      // var list = json.decode(utf8.decode(response.bodyBytes)) as Token;
      // Token token = Token.fromJson(list);
      User userresponse = User.fromJson(jsonDecode(response.body));
      LocalStorage.writeUser(userresponse);
      reg.check = true;
    } else if(response.statusCode == 400){
      // // If the server did not return a 201 CREATED response,
      // // then throw an exception.
      // throw Exception('Failed to log in.');
      reg.check = false;
      String error = jsonDecode(response.body)['detail'];
      reg.error = error;
    }else{
      reg.check = false;
      String error = jsonDecode(response.body)['detail'];
      reg.error = error;
    }
    return reg;
  }

  static Future<String> postLogin(String username,String password) async {
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
      return response.body;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to log in.');
    }
  }
}