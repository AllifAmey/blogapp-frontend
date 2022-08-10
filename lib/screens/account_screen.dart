import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';

import './homepage_screen.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);
  static const routeName = "blog-main/account/";

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Account Page"),
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
              SizedBox(height: 20,),
              Text("${userData.getUser()}"),
              SizedBox(height: 20,),
              CircleAvatar(
                  radius: 200,
                  backgroundImage: AssetImage('assets/images/default_user_profile_img.png')),
              Container(
                height: 200,
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.solidUser,),
                        label: Text("Profile Settings")
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          // clears the stack.
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(),
                            ),
                                (route) => false,
                          );
                        },
                        icon: FaIcon(FontAwesomeIcons.solidUser,),
                        label: Text("Log Out")
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                        },
                        icon: FaIcon(FontAwesomeIcons.solidUser,),
                        label: Text("To Be Announced")
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
