import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';
import '../providers/user_blog_provider.dart';

import './blog_create_form_screen.dart';
import './account_profile_screen.dart';
import './blog_individual_screen.dart';

class BlogMain extends StatelessWidget {
  static const routeName = 'blog-main/';
  const BlogMain({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final userBlog = Provider.of<UserBlogProvider>(context);

    List<Widget> createBlogList(BuildContext ctx) {

      // function that returns a list of blogs or a list of widgets .

      final userBlogList = userBlog.blog_list;
      List<Widget> blogListWidgets = [];
      userBlogList.map((blog) {
        blogListWidgets.add(
            GestureDetector(
              onTap: () {
                //
                Navigator.of(ctx).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return Blog(
                        userName: blog.username as String,
                        blogTitle: blog.title as String,
                        blogContent: blog.blogContent as String,
                      );
                    }
                  )
                );
              },
              child: Container(
                height: 50,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("${blog.username as String}'s Blog: "),
                      Text(blog.title as String),
                    ],
                  ),
                ),
              ),
            )
        );
      }).toList();
      return blogListWidgets;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text("Blogs from Users"),
            FaIcon(FontAwesomeIcons.faceSmile)
          ],
        ),
      ),
        body: FutureBuilder(
          future: userBlog.fetchBlogs(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            else {
              return Container(
                height: 700,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: createBlogList(context),
                ),
              );
            }
          },
        ),
    );
  }
}


