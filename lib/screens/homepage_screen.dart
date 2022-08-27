import 'package:flutter/material.dart';

import './auth_login_screen.dart';
import './auth_signup_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/homepage_bg.jpg"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 200,
          width: double.infinity,
          child: Card(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Welcome to the blog app!"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LogIn.routeName);
                      },
                      child: const Text("Log in")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignUp.routeName);
                      },
                      child: const Text("Sign Up"))
                ],
              )
            ],
          )),
        ),
      ),
    ));
  }
}
