import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './tabs_screen.dart';
import './account_blog_settings_screen.dart';

class AccountSettings extends StatelessWidget {
  // Account setting page with a list of customisation.

  const AccountSettings({Key? key}) : super(key: key);
  static const routeName = "blog-main/account/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) {
                    return TabsScreen(
                        pageNumDefault: 2,
                    );
                  } )
                );
                },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: const Text("Settings options"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
        ListTile(
          title: const Text("Blog App Settings"),
          subtitle: const Text("Change Font Size/style and more!"),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return const AccountBlogSettings();
              })
            );
          },
          trailing: Icon(Icons.arrow_right, color: Colors.blue),
        ),
        ListTile(
          title: const Text("Profile Settings"),
          subtitle: const Text("Change profile picture and online status!!"),
          trailing: const Icon(Icons.arrow_right, color: Colors.blue),
        )
      ]
      )
    );
  }
}
/*

 */