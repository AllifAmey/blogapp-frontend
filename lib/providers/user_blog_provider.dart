import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class UserBlog {
  /*
  User can change:
  font-style,
   */

  final String? username;
  final String? title;
  final String? blogContent;
  final String? location;
  late String? image_type;
  late String? image_url;



  UserBlog({
    this.username,
    this.title,
    this.blogContent,
    this.location,
    this.image_type = "none",
    this.image_url
  });

}

class UserBlogProvider with ChangeNotifier {


  UserBlogProvider();

  List<UserBlog> blog_list = [];

  Image? blogTempImage;


  /*
  void createBlog(UserBlog blog) {
    blog_list.add(blog);
  } */

  List<UserBlog> getBlogList() {
    print(blog_list);
    return blog_list;
  }

  void clearBlogList() {
    blog_list = [];
  }

  // http://localhost:8000/api/userblog-viewset/

  Future<void> fetchBlogs() async {
    // reset blog_list
    blog_list = [];

    const url = 'http://10.0.2.2:8000/api/userblog-viewset/';

    final response = await http.get(Uri.parse(url));
    final userblogs = json.decode(response.body);

    for(var i=0;i<userblogs.length;i++){
      blog_list.add(UserBlog(
            username: userblogs[i]["author"],
            title: userblogs[i]["title"],
            blogContent: userblogs[i]["content"],
            image_type:userblogs[i]["image_type"],
            image_url: userblogs[i]["image_url"],
        ));
    }

  }

  Future<void> createBlog(UserBlog blog, String? imageType, String? imageUrl) async {
    const url = 'http://10.0.2.2:8000/api/userblog-viewset/';
    print(imageUrl);

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'user': int.parse(blog.username as String) , 'title': blog.title, 'content': blog.blogContent, 'image_type': imageType, 'image_url': imageUrl
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created the user!!");
  }

  Future<void> postBlogImage(File imageCamera, String title) async {
    // uploading blog image to firebase storage


    // ref location in storage
    final storageRef = FirebaseStorage.instance.ref(
        "images/blogs");

    // Create a reference
    final profilePictureRef = storageRef.child("$title.jpg");

    // Create a reference to 'images/$username.jpg'
    final profilePictureImagesRef = storageRef.child(
        "images/user_profile_pictures/$title.jpg");

    // the references point to different files
    assert(profilePictureRef.name == profilePictureImagesRef.name);
    assert(profilePictureRef.fullPath != profilePictureImagesRef.fullPath);


    try {
      await profilePictureRef.putFile(imageCamera);
    } on firebase_core.FirebaseException catch (e) {
      // ...
    }
  }


  Future<void> grabBlogImage(String blogTitle) async {
    // grab blog image from fire storage .

    // Create a storage reference from the app
    final storageRef = FirebaseStorage.instance.ref();

    print(blogTitle);
    final userProfileImageRef = storageRef.child("images/blogs/$blogTitle.jpg");

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await userProfileImageRef.getData(oneMegabyte);
      Image blogImage = Image.memory(data!);
      blogTempImage = blogImage;
    } on FirebaseException catch (e) {
      // Handle any errors.
    }
  }






/*

  final Map<String, dynamic>? user_authToken = {
    'username': '',
    'authToken': '',
  };

  Future<void> createUser(UserProfile user) async {
    const url = 'http://10.0.2.2:8000/api/userprofile-viewset/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'username': user.userName, 'password': user.userPass,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created the user!!");
  }

  Future<void> authToken(UserProfile user) async {
    const url = 'http://10.0.2.2:8000/api/api-token-auth/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode({'username': user.userName, 'password': user.userPass}));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created a authentication token!");
  } */

}