import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './tabs_screen.dart';

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
      body: Center(
        child: ListView(
          children: const [
          ListTile(
            title: Text("Blog App Settings"),
            subtitle: Text("Change Font Size/style and more!"),
            trailing: Icon(Icons.arrow_right, color: Colors.blue),
          ),
          ListTile(
            title: Text("Profile Settings"),
            subtitle: Text("Change profile picture and online status!!"),
            trailing: Icon(Icons.arrow_right, color: Colors.blue),
          )
        ]
        ),
    )
    );
  }
}
/*

 */