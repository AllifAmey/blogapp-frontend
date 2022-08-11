import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';

import './homepage_screen.dart';
import './account_settings_screen.dart';

class Account extends StatelessWidget {
  // Account profile screen where user can adjust app-wide settings.
  const Account({Key? key}) : super(key: key);
  static const routeName = "blog-main/account/";

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context);

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
              Text("${userData.getUser()}"),
              const SizedBox(height: 20,),
              const CircleAvatar(
                  radius: 200,
                  backgroundImage: AssetImage('assets/images/default_user_profile_img.png')),
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
                        label: Text("Account Settings")
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
