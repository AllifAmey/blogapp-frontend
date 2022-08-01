import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';

import './blog_main.dart';

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
    // list of users.
    final user = Provider.of<UserProvider>(context);
    String userLoginUsername = "";
    String userLoginPassword = "";



    void saveform () {
      _form.currentState?.save();
      // login page api checks if the user has a authentication token before they're allowed in.
      user.loginUser(userLoginUsername, userLoginPassword).then((String auth_status) {
        if (auth_status == "authenticated") {
          user.currentUsername = userLoginUsername;
          Navigator.of(context).pushNamed(BlogMain.routeName);
        }
        else {
          print(auth_status);
        }
      });
    }




    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/homepage_bg.jpg"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Form(
              key: _form,
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: 400,
                width: double.infinity,
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Log In!"),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: FaIcon(FontAwesomeIcons.user),
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
                              icon: FaIcon(FontAwesomeIcons.user),
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
                                  child: Text("Log In")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Go Back!!")),
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
