import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';
import '../providers/user_blog_provider.dart';
import './blog_main.dart';
import 'blog_individual.dart';


class BlogCreateForm extends StatefulWidget {
  const BlogCreateForm({Key? key}) : super(key: key);
  static const routeName = 'blog-main/create';

  @override
  State<BlogCreateForm> createState() => _BlogCreateFormState();
}

class _BlogCreateFormState extends State<BlogCreateForm> {

  final _form = GlobalKey<FormState>();

  String blogTitle = '';
  String blogContent = '';
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final userBlogUnconfirmed = Provider.of<UserBlogProvider>(context);
    final user = Provider.of<UserProvider>(context);

    UserBlog _editedUserBlog = UserBlog(username: user.getUserId().toString(), title: blogTitle, blogContent: blogContent);

    void blogConfirmationPage (BuildContext ctx ) {
      // widget shown after user presses create blog button
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
              ],
            )
        );
      },);
    }

    void saveForm(BuildContext ctx, [bool preview = false]) {
      // option to preview blog and to confirm
      if (preview = true) {
        _form.currentState?.save();
        Navigator.of(ctx).push(
            MaterialPageRoute(
                builder: (_) {
                  return Blog(
                    userName: _editedUserBlog.username as String,
                    blogTitle: _editedUserBlog.title as String,
                    blogContent: _editedUserBlog.blogContent as String,
                    preview: true,
                  );
                }
            ));
      }
      else{
        _form.currentState?.save();
        blogConfirmationPage(ctx);
      }
    }
    // where the form is created
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Blog!"),
      ),
      body: Stepper(
        type: StepperType.vertical,
        steps: [
          Step(title: Text("Blog"),
            content: Form(
              key: _form,
              child: SingleChildScrollView(
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
            ),
          ),
          Step(
              title: Text("Location"),
              content: Text("Location")
          ),
          Step(
              title: Text("Picture"),
              content: Text("Picture")
          ),
          Step(
              title: Text("Confirm"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                      ElevatedButton(
                        onPressed: () {
                          saveForm(context);
                        },
                        child: Text("Preview!"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          saveForm(context);
                        },
                        child: Text("Confirm Blog"),
                      ),
                  ]
              )
          ),

        ],
                onStepTapped: (int newIndex) {
                  setState(() {
                    _currentStep: newIndex;
                  });},
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep != 3) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep != 0 ) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
      ),
    );
  }
}
