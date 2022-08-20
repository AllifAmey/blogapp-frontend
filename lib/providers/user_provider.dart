import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {


  UserProvider();

  String currentUsername = "";
  int currentUsernameId = 0;

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
    //This creates the authentication for the user
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

  Future<Map<String, dynamic>> loginUser(String userName, String userPass) async {
    // Authenticates user and returns values attached to user if authenticated
    const url = 'http://10.0.2.2:8000/api/auth/login/';
    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'username': userName, 'password': userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    //
    print(jsonData);
    if (jsonData['auth_status'] == 'Authenticated') {
      currentUsernameId = jsonData['user_id'];
      // "authenticated"
      return jsonData;
    }
    else {
      return jsonData;
    }
  }

}