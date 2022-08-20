import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/user_app_setting_provider.dart';

class AccountBlogSettings extends StatefulWidget {
  // Account settings for Blog

  String? currentFont = "";

  AccountBlogSettings({Key? key}) : super(key: key);

  static const routeName = "blog-main/account/settings/blog";

  @override
  State<AccountBlogSettings> createState() => _AccountBlogSettingsState();
}

class _AccountBlogSettingsState extends State<AccountBlogSettings> {


  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context);
    final currentUserSettings = Provider.of<UserAppSettingsProvider>(context);

    if (widget.currentFont == "") {
      setState(() {
        widget.currentFont = currentUserSettings.userSettings?.fontFamily;
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Blog Settings"),
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
              value: widget.currentFont == "Roboto" ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    widget.currentFont = "Roboto";
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
              value: widget.currentFont == "Merriweather" ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    widget.currentFont = "Merriweather";
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
              value: widget.currentFont == "Lobster" ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    widget.currentFont = "Lobster";
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
              value: widget.currentFont == "IndieFlower" ? true : false,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    widget.currentFont = "IndieFlower";
                  }
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // update method
          currentUserSettings.changeUserSettings(
              currentUserSettings.userSettingsId,
              currentUser.currentUsernameId,
              widget.currentFont as String);
          Navigator.pop(context);
        },
        child: Text("Submit"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
