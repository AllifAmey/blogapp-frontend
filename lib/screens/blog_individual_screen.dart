import 'dart:ffi';

import 'package:flutter/material.dart';

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
                  child: Text(this.blogTitle)),
              const SizedBox(
                height: 30,
              ),
              Text(this.blogContent),
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
