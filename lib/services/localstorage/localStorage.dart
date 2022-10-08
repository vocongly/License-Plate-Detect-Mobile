// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:license_plate_detect/core/models/Token.dart';
import 'package:license_plate_detect/core/models/User.dart';

class LocalStorage {
  static final _token = Hive.box('token');
  static final _user = Hive.box('user');

  //write data
  static void writeToken(String? accessToken, String? tokenType) async {
    _token.put(1, accessToken);
    _token.put(2, tokenType);

    print(accessToken);
    print(tokenType);
  }

  //read data
  static Token getToken() {
    Token token = new Token();
    token.accessToken = _token.get(1);
    token.tokenType = _token.get(2);
    return token;
  }

  // delete data
  static void deleteToken() async {
    _token.deleteAll([1, 2]);
  }

  static Future<bool> checkToken() async {
    bool check = true;
    if (getToken() != null) {
      check = false;
    }
    return await check;
  }

  static void writeUser(User user) {
    _user.put(1, user.sId);
    _user.put(2, user.email);
    _user.put(3, user.username);
    _user.put(4, user.phoneNumber);
    _user.put(5, user.firstName);
    _user.put(6, user.lastName);
    _user.put(7, user.avatar);
  }

  //read data
  static User getUser() {
    User user = new User();
    user.sId = _user.get(1);
    user.email = _user.get(2);
    user.username = _user.get(3);
    user.phoneNumber = _user.get(4);
    user.firstName = _user.get(5);
    user.lastName = _user.get(6);
    user.avatar = _user.get(7);
    return user;
  }

  // delete data
  static void deleteUser() async {
    _user.deleteAll([1, 2, 3, 4, 5, 6, 7]);
  }
}
