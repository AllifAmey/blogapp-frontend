import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserAppSettings {
  /*
  User can change:
  font-style,
   */
  final String? username;
  final String? fontFamily;


  UserAppSettings({required this.username, required this.fontFamily});

}

class UserAppSettingsProvider with ChangeNotifier {


  UserAppSettingsProvider();

  UserAppSettings? userSettings;

  void changeUserSettings(String currentuser, String changefontFamily) {

    userSettings = UserAppSettings(username: currentuser, fontFamily: changefontFamily);
  }
/*

  final Map<String, dynamic>? user_authToken = {
    'username': '',
    'authToken': '',
  };

  Future<void> createUser(UserProfile user) async {
    const url = 'http://10.0.2.2:8000/api/userprofile-viewset/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'username': user.userName, 'password': user.userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created the user!!");
  }

  Future<void> authToken(UserProfile user) async {
    const url = 'http://10.0.2.2:8000/api/api-token-auth/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode({'username': user.userName, 'password': user.userPass}));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created a authentication token!");
  } */

}