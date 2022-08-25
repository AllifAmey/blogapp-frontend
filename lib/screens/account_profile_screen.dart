import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/user_provider.dart';
import '../providers/user_app_setting_provider.dart';

import './homepage_screen.dart';
import './account_settings_screen.dart';

class Account extends StatefulWidget {
  // Account profile screen where user can adjust app-wide settings.
  const Account({Key? key}) : super(key: key);
  static const routeName = "blog-main/account/";

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context);
    var userProfilePicture = Provider.of<UserAppSettingsProvider>(context);
    File? pickedImage;

    void _pickImage() async {
      // picks the image using the camera
      // image is converted to a file class and stored in UserAppSettings Provider
      final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        pickedImage= File(pickedImageFile?.path as String);
        userProfilePicture.postImage(pickedImage!, userData.currentUsername).then((value) => userProfilePicture.changeUserSettings(userProfilePicture.userSettingsId, userData.currentUsernameId, userProfilePicture.userSettings?.fontFamily as String, "Yes"));
        userProfilePicture.userProfilePicture = Image.file(pickedImage!);
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Account Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/homepage_bg.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Text(userData.getUser()),
              const SizedBox(height: 20,),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [CircleAvatar(
                    radius: 200,
                    backgroundImage: userProfilePicture.userProfilePicture==null ? const AssetImage('assets/images/default_user_profile_img.png') : userProfilePicture.userProfilePicture?.image,
                ),
                  if (userProfilePicture.userProfilePicture==null) IconButton(
                    iconSize: 150.0,
                    onPressed: _pickImage,
                    icon: const FaIcon(FontAwesomeIcons.camera),
                  )
                ]
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(AccountSettings.routeName);
                        },
                        icon: const FaIcon(FontAwesomeIcons.solidUser,),
                        label: const Text("Account Settings")
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          // clears the stack.

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const HomePage(),
                            ),
                                (route) => false,
                          );
                        },
                        icon: const FaIcon(FontAwesomeIcons.solidUser,),
                        label: const Text("Log Out")
                    ),
                    ElevatedButton.icon(
                        onPressed: () {

                        },
                        icon: const FaIcon(FontAwesomeIcons.solidUser,),
                        label: const Text("To Be Announced")
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
