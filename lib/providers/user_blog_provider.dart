import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserBlog {
  /*
  User can change:
  font-style,
  font-size,
   */

  final String? username;
  final String? title;
  final String? blogContent;


  UserBlog({required this.username, required this.title, required this.blogContent});

}

class UserBlogProvider with ChangeNotifier {


  UserBlogProvider();

  List<UserBlog> blog_list = [];

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
    print("I was touched!");

    const url = 'http://10.0.2.2:8000/api/userblog-viewset/';

    final response = await http.get(Uri.parse(url));
    final userblogs = json.decode(response.body);

    for(var i=0;i<userblogs.length;i++){
      blog_list.add(UserBlog(
            username: userblogs[i]["author"],
            title: userblogs[i]["title"],
            blogContent: userblogs[i]["content"],
        ));
    }

  }

  Future<void> createBlog(UserBlog blog) async {
    const url = 'http://10.0.2.2:8000/api/userblog-viewset/';

    final response = await http.post(Uri.parse(url),headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: json.encode(
        {
          'user': int.parse(blog.username as String) , 'title': blog.title, 'content': blog.blogContent,
        }));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;

    print(jsonData);
    print("I created the user!!");
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