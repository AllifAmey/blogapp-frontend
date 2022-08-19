import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile {

  final String? userName;
  final String? userPass;


  UserProfile({required this.userName, required this.userPass});

}

class UserProvider with ChangeNotifier {


  UserProvider();

  List<UserProfile> users = [];

  String currentUsername = "";
  int currentUsernameId = 0;

  List<UserProfile> listUsers() {
    print(users);
    return users;
  }

  String getUser() {
    return currentUsername;
  }

  int getUserId() {
    return currentUsernameId;
  }


  Future<void> createUser(String userName, String userPass) async {
    const url = 'http://10.0.2.2:8000/api/register-viewset/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'username': userName, 'password': userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created the user!!");
  }

  Future<void> createUserAuth(String userName, String userPass) async {
    const url = 'http://10.0.2.2:8000/api/signup/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'username': userName, 'password': userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created the user Authentication");
  }

  String userAuthenticated(String auth_status) {
    return auth_status;
  }

  Future<String> loginUser(String userName, String userPass) async {
    const url = 'http://10.0.2.2:8000/api/user_auth/';
    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'username': userName, 'password': userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    if (jsonData['message'] == 'Authenticated') {
      currentUsernameId = jsonData['user_id'];
      return "authenticated";
    }
    else {
      return jsonData['message'];
    }
  }

}