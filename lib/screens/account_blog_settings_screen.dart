import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_app_setting_provider.dart';

class AccountBlogSettings extends StatefulWidget {
  // Account settings for Blog
  const AccountBlogSettings({Key? key}) : super(key: key);

  static const routeName = "blog-main/account/settings/blog";

  @override
  State<AccountBlogSettings> createState() => _AccountBlogSettingsState();
}

class _AccountBlogSettingsState extends State<AccountBlogSettings> {

  String currentFont = "";

  @override
  Widget build(BuildContext context) {
    final currentAppSettings = Provider.of<UserAppSettingsProvider>(context);
    var currentUserFont = currentAppSettings.userSettings?.fontFamily;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Blog Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          ListTile(
              title: Text("Blog Font Size",
              textAlign: TextAlign.center,)
          ),
          ListTile(
            title: const Text("Font Size"),
            trailing: Container(
              width: 30,
              child: TextFormField(
              ),
            ),
          ),
          ListTile(
              title: Text("Blog Font Style",
                  textAlign: TextAlign.center,)
          ),
          ListTile(
              title: Text("Roboto",
              style: TextStyle(
                fontFamily: "Roboto"
              ),),
            trailing: Switch(
              value: currentUserFont == "Roboto" ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    currentAppSettings.changeUserSettings("Mickey", "Roboto");
                  }
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            title: Text("Merriweather",
            style: TextStyle(
              fontFamily: "Merriweather",
            ),),
            trailing: Switch(
              value: currentUserFont == "Merriweather" ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    currentAppSettings.changeUserSettings("Mickey", "Merriweather");
                  }
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            title: Text("Lobster",
            style: TextStyle(
              fontFamily: "Lobster",
              letterSpacing: 5,
              fontSize: 20,
            )),
            trailing: Switch(
              value: currentUserFont == "Lobster" ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    currentAppSettings.changeUserSettings("Mickey", "Lobster");
                  }
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
          ListTile(
            title: Text("IndieFlower",
            style: TextStyle(
              fontFamily: "IndieFlower",
              fontSize: 20,
            ),),
            trailing: Switch(
              value: currentUserFont == "IndieFlower" ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    currentAppSettings.changeUserSettings("Mickey", "IndieFlower");
                  }
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
