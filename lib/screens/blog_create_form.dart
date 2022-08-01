import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';
import '../providers/user_blog_provider.dart';
import './blog_main.dart';


class BlogCreateForm extends StatefulWidget {
  const BlogCreateForm({Key? key}) : super(key: key);
  static const routeName = 'blog-main/create';

  @override
  State<BlogCreateForm> createState() => _BlogCreateFormState();
}

class _BlogCreateFormState extends State<BlogCreateForm> {

  final _form = GlobalKey<FormState>();



  String title = '';
  String blogContent = '';




  @override
  Widget build(BuildContext context) {
    final userBlogUnconfirmed = Provider.of<UserBlogProvider>(context);
    final user = Provider.of<UserProvider>(context);

    UserBlog _editedUserBlog = UserBlog(username: user.getUserId().toString(), title: title, blogContent: blogContent);

    void blogConfirmationPage (BuildContext ctx ) {
      showModalBottomSheet(
        elevation: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: ctx, builder: (_) {
        return Container(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Are you sure?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {
                      Navigator.pop(ctx);
                    }, child: Text("Go back")),
                    ElevatedButton(onPressed: () {
                      userBlogUnconfirmed.createBlog(_editedUserBlog);
                      Navigator.of(context).pushNamed(BlogMain.routeName);
                    } , child: Text("Create Blog")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {

                      userBlogUnconfirmed.clearBlogList();
                    } , child: Text("Clear all Blogs")),
                    ElevatedButton(onPressed: () {
                      userBlogUnconfirmed.getBlogList();

                    } , child: Text("Get all Blogs")),
                  ],
                )

              ],
            )
        );
      },);
    }

    void saveform(BuildContext ctx) {
      _form.currentState?.save();
      blogConfirmationPage(ctx);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Blog!"),
      ),
      body: Form(
        key: _form,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 1,
                onSaved: (value) {
                  _editedUserBlog = UserBlog(username: user.getUserId().toString(), title: value, blogContent: _editedUserBlog.blogContent);
                },
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Blog Content",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 20,
                onChanged: (value) {

                },
                onSaved: (value) {
                  _editedUserBlog = UserBlog(username: user.getUserId().toString(), title: _editedUserBlog.title, blogContent: value);
                },

              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveform(context);
        },
        label: Text("Create Blog!"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
