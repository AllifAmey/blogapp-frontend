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

    List<String> fontStyleList = [
      "Roboto",
      "Merriweather",
      "Lobster",
      "IndieFlower"
    ];

    if (widget.currentFont == "") {
      setState(() {
        widget.currentFont = currentUserSettings.userSettings?.fontFamily;
      });
    }
    List<Widget> _buildListTileFontStyle(List<String> fontStyleList ) {
      // builder method to add more font-styles in the future
      // To add more fontstyles, add String to the fontStyleList only

      List<Widget> fontStyleWidgetList = [];
      for (var i=0; i<fontStyleList.length; i++) {
        fontStyleWidgetList.add(
            ListTile(
              title: Text(
                fontStyleList[i],
                style: TextStyle(
                  fontFamily: fontStyleList[i],
                ),
              ),
              trailing: Switch(
                value: widget.currentFont == fontStyleList[i] ? true : false,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      widget.currentFont = fontStyleList[i];
                    }
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            )
        );
      }
      return fontStyleWidgetList;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Blog Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          const ListTile(
              title: Text(
            "Blog Font Style",
            textAlign: TextAlign.center,
          )),
          ..._buildListTileFontStyle(fontStyleList)
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // update method
          if (currentUserSettings.userProfilePicture == null) {
            currentUserSettings.changeUserSettings(
                currentUserSettings.userSettingsId,
                currentUser.currentUsernameId,
                widget.currentFont as String,
                "No");
          } else {
            currentUserSettings.changeUserSettings(
                currentUserSettings.userSettingsId,
                currentUser.currentUsernameId,
                widget.currentFont as String,
                "Yes");
          }
          Navigator.pop(context);
        },
        child: const Text("Submit"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
