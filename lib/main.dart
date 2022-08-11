import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/homepage_screen.dart';
import './screens/auth_login_screen.dart';
import './screens/auth_signup_screen.dart';
import './screens/blog_main_screen.dart';
import './screens/blog_create_form_screen.dart';
import './screens/account_profile_screen.dart';
import './screens/tabs_screen.dart';
import './screens/account_settings_screen.dart';

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
      ], child: const Blog()));
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
          LogIn.routeName : (ctx) => const LogIn(),
          SignUp.routeName : (ctx) => const SignUp(),
          BlogMain.routeName : (ctx) => const BlogMain(),
          BlogCreateForm.routeName: (ctx) => const BlogCreateForm(),
          Account.routeName: (ctx) => const Account(),
          TabsScreen.routeName: (ctx) => TabsScreen(pageNumDefault: 0,),
          AccountSettings.routeName: (ctx) => const AccountSettings(),
        },
      );
  }
}
