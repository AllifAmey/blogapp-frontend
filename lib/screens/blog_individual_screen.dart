import 'package:blog/providers/user_blog_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../providers/user_app_setting_provider.dart';

class BlogScreen extends StatelessWidget {
  // individual blog screen
  String? userName;
  String? blogTitle;
  String? blogContent;
  bool? preview;
  String? imageType;
  String? imageUrl;
  File? imageFile;

  BlogScreen({
    required this.userName,
    required this.blogTitle,
    required this.blogContent,
    this.preview = false,
    this.imageType = "none",
    this.imageUrl = "none",
    this.imageFile = null,
  });

  Widget? _buildBlogImage(String? imageType, String? imageUrl,
      [Image? imageFile]) {
    // builder method to build the image displayed for the blog.
    if (imageType == "none") {
      return Image.asset("assets/images/default_blog_picture.png");
    } else if ((imageType == "gallery") | (imageType == "camera")) {
      return imageFile;
    } else if (imageType == "internet") {
      return Image.network(imageUrl!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userblogSettings = Provider.of<UserAppSettingsProvider>(context);
    final userbloginfo = Provider.of<UserBlogProvider>(context);
    print(blogTitle);
    return Scaffold(
      appBar: AppBar(
        title: preview! ? const Text("Preview") : Text(userName!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                height: 200,
                width: 200,
                child: imageType != "internet"
                    ? preview == false ? FutureBuilder(
                        future: userbloginfo.grabBlogImage(blogTitle!),
                        builder: (context, dataSnapshot) {
                          if (dataSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return _buildBlogImage(imageType, imageUrl,
                                userbloginfo.blogTempImage) as Widget;
                          }
                        }) : Image.file(imageFile!)
                    : _buildBlogImage(imageType, imageUrl),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(blogTitle!,
                  style: TextStyle(
                    fontFamily: userblogSettings.userSettings?.fontFamily,
                    fontSize: 30,
                  )),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  blogContent!,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: userblogSettings.userSettings?.fontFamily,
                  ),
                ),
              ),
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
          child: Text(
            "Back",
          ),
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
