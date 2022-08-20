import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';
import '../providers/user_app_setting_provider.dart';

import './tabs_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  static const routeName = 'auth/login';

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final UserSettings = Provider.of<UserAppSettingsProvider>(context);
    String userLoginUsername = "";
    String userLoginPassword = "";



    void saveform () {
      _form.currentState?.save();
      // login page api checks if the user has a authentication token before they're allowed in.
      user.loginUser(userLoginUsername, userLoginPassword).then((Map<String, dynamic> userStatus) {
        if (userStatus['auth_status'] == "Authenticated") {
          // adds information about user from the backend to the frontend.
          user.currentUsername = userLoginUsername;
          UserSettings.currentUserSettings(userStatus['font_style']);
          UserSettings.userSettingsId = userStatus['setting_id'];
          Navigator.of(context).pushNamed(TabsScreen.routeName);
        }
        else {
          print(userStatus);
        }
      });
    }




    return Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/homepage_bg.jpg"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Form(
              key: _form,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 400,
                width: double.infinity,
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Log In!"),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              labelText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onSaved: (value) {
                              setState(() {
                                if (value != null) {
                                  userLoginUsername = value;
                                }

                              });
                              if (value != null) {
                                userLoginUsername = value;
                              }
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onSaved: (value) {
                              setState(() {
                                if (value != null) {
                                  userLoginPassword = value;
                                }

                              });
                              if (value != null) {
                                userLoginPassword = value;
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    saveform();
                                  },
                                  child: const Text("Log In")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Go Back!!")),
                            ],
                          )
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
        )
    );
  }
}
