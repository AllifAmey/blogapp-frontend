import 'package:flutter/material.dart';

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

  Future<Map<String, dynamic>> createUser(
      String userName, String userPass) async {
    const url = 'http://10.0.2.2:8000/api/register-viewset/';

    final response = await http.post(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': userName,
          'password': userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created the user!!");
    return jsonData;
  }

  Future<void> createUserAuth(String userName, String userPass) async {
    //This creates the authentication for the user
    const url = 'http://10.0.2.2:8000/api/signup/';

    final response = await http.post(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': userName,
          'password': userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created the user Authentication");
  }

  Future<Map<String, dynamic>> loginUser(
      String userName, String userPass) async {
    // Authenticates user and returns values attached to user if authenticated
    const url = 'http://10.0.2.2:8000/api/auth/login/';
    final response = await http.post(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': userName,
          'password': userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    //
    print(jsonData);
    if (jsonData['auth_status'] == 'Authenticated') {
      currentUsernameId = jsonData['user_id'];
      // "authenticated"
      return jsonData;
    } else {
      return jsonData;
    }
  }

  Future<List<dynamic>>? sendBlockUserRequest(String username, String blockUser) async{
    // get the users blocked listed by user
    const url = 'http://10.0.2.2:8000/api/blockeduser-viewset/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },body: json.encode(
      {
        'username' : username,
        'block user': blockUser
      }
    )
    );
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    print("$username added $blockUser to their block list!");
    return jsonData;
  }

  Future<List<dynamic>>? sendFriendRequest(String username, String requestFriendUsername) async{
    // get the users blocked listed by user
    const url = 'http://10.0.2.2:8000/api/friend-viewset/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },body: json.encode(
      {
        'username': username,
        'friend request': requestFriendUsername
      }
    ));
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    print("$username sent a friend request to $requestFriendUsername!");
    return jsonData;
  }
  Future<List<dynamic>>? getBlockId(String username, String requestFriendUsername ) async{
    // get the users blocked listed by user
    final url = 'http://10.0.2.2:8000/api/grab/id/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },body: json.encode(
        {
          'type': 'block',
          'username': username,
          'target user': requestFriendUsername
        }
    ));
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    return jsonData;
  }

  Future<List<dynamic>>? getFriendId(String username, String requestFriendUsername ) async{
    // get the users blocked listed by user
    final url = 'http://10.0.2.2:8000/api/grab/id/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },body: json.encode(
        {
          'type': 'friend',
          'username': username,
          'target user': requestFriendUsername
        }
    ));
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    return jsonData;
  }


  Future<List<dynamic>>? unBlockRequest(String username, String unBlockUser, int blockId) async{
    // get the users blocked listed by user
    final url = 'http://10.0.2.2:8000/api/blockeduser-viewset/$blockId/';

    final response = await http.delete(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },body: json.encode(
        {
          'username': username,
          'unblock user': unBlockUser
        }
    ));
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    print("$username has decided to unblock $unBlockUser!");
    return jsonData;
  }

  Future<List<dynamic>>? unFriendRequest(String username, String formerFriend, int friendId) async{
    // get the users blocked listed by user
    final url = 'http://10.0.2.2:8000/api/friend-viewset/$friendId/';

    final response = await http.delete(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },body: json.encode(
        {
          'username': username,
          'former_friend': formerFriend
        }
    ));
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    print("$username has decided to unfriend $formerFriend!");
    return jsonData;
  }

  Future<List<dynamic>>? acceptFriendRequest(String username, String requestFriendUsername, int friendId) async{
    // get the users blocked listed by user
    final url = 'http://10.0.2.2:8000/api/friend-viewset/$friendId/';

    final response = await http.patch(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },body: json.encode(
        {
          'username': username,
          'friend_requester': requestFriendUsername
        }
    ));
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    print("$username acceped a friend request from $requestFriendUsername!");
    return jsonData;
  }



  Future<List<dynamic>>? getBlockedList(String username) async{
    // get the users blocked listed by user
    const url = 'http://10.0.2.2:8000/api/blockeduser-viewset/';

    final response = await http.get(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'username': username
    },);
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    print("All blocked users!");
    return jsonData;
  }

  Future<List<dynamic>>? getFriendList(String username) async {
    // get the friend listed to that particular user
    const url = 'http://10.0.2.2:8000/api/friend-viewset/';
    final response = await http.get(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'username': username
    },);
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    print("All friends!");
    return jsonData;
  }

  Future<List<dynamic>> getUsersRegistered(String username) async {
    // get users registered and their relations to username
    const url = 'http://10.0.2.2:8000/api/auth/login/';
    print(username);
    // send header here
    final response = await http.get(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'username': username
    },);
    final jsonData = json.decode(response.body) as List<dynamic>;

    print(jsonData);
    print("All users registered!");
    return jsonData;
  }

}
