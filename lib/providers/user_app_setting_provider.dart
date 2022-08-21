import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserAppSettings {
  // This model will contain user's setting for the app.

  final String? fontFamily;


  UserAppSettings({required this.fontFamily});

}

class UserAppSettingsProvider with ChangeNotifier {


  UserAppSettingsProvider();

  UserAppSettings? userSettings;
  File? userProfilePicture;

  int userSettingsId = 0;

  void currentUserSettings(String changefontFamily) {
    //establish
    userSettings = UserAppSettings(fontFamily: changefontFamily);
  }

  Future<void> changeUserSettings(int settingID, int userId, String newFontFamily) async {
    // Changes user settings with patch
    var url = 'http://10.0.2.2:8000/api/profilesetting-viewset/$settingID/';
    print(userId);

    final response = await http.patch(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'id': settingID,
          'user': userId,
          'font_style': newFontFamily
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    print(jsonData);
    if (response.statusCode == 200) {
      userSettings = UserAppSettings(fontFamily: newFontFamily);
    }

  }

  //Note to self: find a way to send to backend later.

  Future<void> postImage(File imageCamera) async {
    //const url = 'http://10.0.2.2:8000/api/profilepicture/';
    //const url = 'http://10.0.2.2:8000/api/profilepicturesetting-viewset/';
    const url = 'https://api.imgur.com/3/upload';

    /*
    final pngByteData = await rootBundle.load('assets/images/homepage_bg.jpg');
    print(pngByteData);
    final image = await pngByteData.buffer.asUint8List();
    final response = await http.put(Uri.parse(url), headers: {
      'Accept': '',
      'Content-Type': 'image/jpeg',
      'Content-Disposition': 'attachment; filename=profileimage'
    }, body: await imageCamera.readAsBytes().asStream());
    print("I created the image!!");
    */


    var request = http.MultipartRequest("POST",Uri.parse(url));

    request.fields['title'] = "homepage_bg";
    request.headers['Authorization'] = "Client-ID" + "a842c7a08875138";

    var picture = http.MultipartFile.fromBytes(
        'image',
        (await rootBundle.load('assets/images/homepage_bg.jpg')).buffer.asUint8List(),
        filename: "testimage.png"
    );

    request.files.add(picture);


    request.send().then((response) async {
      print(response.statusCode);
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);
      print(result);
      if (response.statusCode == 200) {
        print("It worked!!");
      }
    });


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