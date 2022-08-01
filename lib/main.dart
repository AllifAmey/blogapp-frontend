import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/homepage.dart';
import './screens/auth_login.dart';
import './screens/auth_signup.dart';
import './screens/blog_main.dart';
import './screens/blog_create_form.dart';
import './screens/account.dart';

import './providers/user_provider.dart';
import './providers/user_app_setting_provider.dart';
import './providers/user_blog_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider(),),
        ChangeNotifierProvider(create: (ctx) => UserAppSettingsProvider(),),
        ChangeNotifierProvider(create: (ctx) => UserProvider(),),
        ChangeNotifierProvider(create: (ctx) => UserBlogProvider(),)
      ], child: Blog()));
}

class Blog extends StatelessWidget {
  const Blog({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final userAppSetting = Provider.of<UserAppSettingsProvider>(context);
    final userBlog = Provider.of<UserBlogProvider>(context);
    userBlog.fetchBlogs();
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            headline6: TextStyle(
            ),
          ),
          appBarTheme: const AppBarTheme(
            // color: Colors.deepOrange,
          ),
        ),
        routes: {
          '/': (ctx) => const HomePage(),
          LogIn.routeName : (ctx) => LogIn(),
          SignUp.routeName : (ctx) => SignUp(),
          BlogMain.routeName : (ctx) => BlogMain(),
          BlogCreateForm.routeName: (ctx) => BlogCreateForm(),
          Account.routeName: (ctx) => Account(),
        },
      );
  }
}
