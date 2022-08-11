import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';

import './blog_main_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  static const routeName = 'auth/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();

  String? username;
  String? pass1;
  String? pass2;



  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context);

    void saveform() {
      if (_form.currentState?.validate() as bool) {

        _form.currentState?.validate();
        _form.currentState?.save();
        // line below creates User and then adds a authentication token so that they can use login page
        userData.createUser(username as String, pass1 as String).then((_) => userData.createUserAuth(username as String, pass1 as String));
        userData.currentUsername = username as String;
        Navigator.of(context).pushNamed(BlogMain.routeName);
      }

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
                height: 600,
                width: double.infinity,
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Sign up!"),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              labelText: "Username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onChanged: (value) {
                              username = value;
                            },
                            onSaved: (value) {
                              username = value;

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
                            validator: (validate) {
                              if (pass1 != pass2) {
                                return "Password is not the same.";
                              }
                              else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              pass1 = value;
                            },
                            onSaved: (value) {
                              pass1 = value;

                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              labelText: "Repeat Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (validate) {
                              if (pass1 != pass2) {
                                return "Password is not the same.";
                              }
                              else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              pass2 = value;
                            },
                            onSaved: (value) {
                              pass2 = value;

                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    saveform();
                                  },
                                  child: const Text("Sign Up")),
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
