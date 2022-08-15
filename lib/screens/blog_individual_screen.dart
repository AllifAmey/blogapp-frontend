import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/user_app_setting_provider.dart';

class Blog extends StatelessWidget {
  // individual blog screen
  String userName;
  String blogTitle;
  String blogContent;
  bool preview;

  Blog({
    required this.userName,
    required this.blogTitle,
    required this.blogContent,
    this.preview = false
  });

  @override
  Widget build(BuildContext context) {
    final userblogSettings = Provider.of<UserAppSettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: preview ? Text("Preview") : Text(this.userName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset("assets/images/default_blog_picture.png"),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  child: Text(
                      this.blogTitle,
                      style: TextStyle(
                        fontFamily: userblogSettings.userSettings?.fontFamily,
                      )
                  ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(this.blogContent,
              style: TextStyle(
                fontSize: 20,
                fontFamily: userblogSettings.userSettings?.fontFamily,
              ),),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const FittedBox(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Back",),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
