import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:path_provider/path_provider.dart';

class UserAppSettings {
  // This model will contain user's setting for the app.

  final String? fontFamily;

  UserAppSettings({required this.fontFamily});
}

class UserAppSettingsProvider with ChangeNotifier {
  UserAppSettingsProvider();

  UserAppSettings? userSettings;
  Image? userProfilePicture;
  int userSettingsId = 0;

  void currentUserSettings(String changefontFamily) {
    //establish
    userSettings = UserAppSettings(fontFamily: changefontFamily);
  }

  Future<void> changeUserSettings(
      int settingID, int userId, String newFontFamily, String has_image) async {
    // Changes user settings with patch
    var url = 'http://10.0.2.2:8000/api/profilesetting-viewset/$settingID/';

    final response = await http.patch(Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': settingID,
          'user': userId,
          'font_style': newFontFamily,
          'has_image': has_image,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    print(jsonData);
    if (response.statusCode == 200) {
      userSettings = UserAppSettings(fontFamily: newFontFamily);
    }
  }

  Future<void> postImage(File imageCamera, String username) async {
    // uploading image to firebase storage

    // ref location in storage
    final storageRef =
        FirebaseStorage.instance.ref("images/user_profile_pictures");

    // Create a reference
    final profilePictureRef = storageRef.child("$username.jpg");

    // Create a reference to 'images/$username.jpg'
    final profilePictureImagesRef =
        storageRef.child("images/user_profile_pictures/$username.jpg");

    // the references point to different files
    assert(profilePictureRef.name == profilePictureImagesRef.name);
    assert(profilePictureRef.fullPath != profilePictureImagesRef.fullPath);

    try {
      await profilePictureRef.putFile(imageCamera);
    } on firebase_core.FirebaseException catch (e) {
      // ...
    }
  }

  Future<String?> grabImage(String username) async {
    // grab image from fire storage and place it in profile picture.

    // Create a storage reference from the app
    final storageRef = FirebaseStorage.instance.ref();

    final userProfileImageRef =
        storageRef.child("images/user_profile_pictures/$username.jpg");

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await userProfileImageRef.getData(oneMegabyte);
      // Data for "images/island.jpg" is returned, use this as needed.
      print(data.runtimeType);
      userProfilePicture = Image.memory(data!);
      return "Success";
    } on FirebaseException catch (e) {
      // Handle any errors.
      return "Error";
    }
  }
  /*
    // potential django way steps:
      1. upload image to imgur
      2. grab url of image from the response and store in django ProfileSettings model.
      3. To display image use NetworkImage widget and input the url.

    //const url = 'http://10.0.2.2:8000/api/profilesetting-viewset/$settingID/';
    // use above url and use put method on model adjust it.
    // const url = 'https://api.imgur.com/3/upload'; - use url upload to imgur
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
    });*/

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
