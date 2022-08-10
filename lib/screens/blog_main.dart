import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';
import '../providers/user_blog_provider.dart';

import './blog_create_form.dart';
import './account.dart';
import './blog_individual.dart';

class BlogMain extends StatelessWidget {
  static const routeName = 'blog-main/';
  const BlogMain({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final userBlog = Provider.of<UserBlogProvider>(context);

    List<Widget> createBlogList(BuildContext ctx) {

      // function that returns a list of blogs or a list of widgets .

      final userBlogList = userBlog.blog_list;
      List<Widget> BlogListWidgets = [];
      userBlogList.map((blog) {
        BlogListWidgets.add(
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
      return BlogListWidgets;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs from Users"),
        actions: [
          IconButton(onPressed: () {

            Navigator.of(context).pushNamed(Account.routeName);
          }, icon: FaIcon(FontAwesomeIcons.solidUser,))
        ],
      ),
        body: FutureBuilder(
          future: userBlog.fetchBlogs(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            else {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: createBlogList(context),
              );
            }
          },
        ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.of(context).pushNamed(BlogCreateForm.routeName);
        },
        child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Create Blog!",),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
