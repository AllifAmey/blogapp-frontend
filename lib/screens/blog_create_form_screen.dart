import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../providers/user_provider.dart';
import '../providers/user_blog_provider.dart';
import './blog_main_screen.dart';
import 'blog_individual_screen.dart';
import './tabs_screen.dart';


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
  File? pickedImage;
  NetworkImage? pickedInternetImage;
  bool imageFromInternet = false;
  TextEditingController urlImage = TextEditingController();


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
                const Text("Are you sure?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {
                      Navigator.of(ctx).pop();
                    }, child: const Text("Go back")),
                    ElevatedButton(onPressed: () {
                      userBlogUnconfirmed.createBlog(_editedUserBlog);
                      Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
                    } , child: const Text("Create Blog")),
                  ],
                ),
              ],
            )
        );
      },);
    }

    void _pickImageInternet(BuildContext ctx, UserBlog editedBlog) async {
      //
      showDialog(
        context: ctx,
        builder: (_) => Container(
          height: 500,
          child: AlertDialog(
            title: Text("Image from Internet"),
            content: Container(
              height: 200,
              child: Column(
                children: [
                  TextField(
                    controller: urlImage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Type url"
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(onPressed: (){
                        setState(() {
                          pickedInternetImage = NetworkImage(urlImage.text);
                          _editedUserBlog = editedBlog;
                          _editedUserBlog.image_type = "internet";
                          _editedUserBlog.image_url = urlImage.text;
                          Navigator.pop(ctx);
                        });
                      }, child: const Text("Confirm"),),
                      TextButton(onPressed: (){
                        Navigator.pop(ctx);

                      }, child: const Text("Go back"),),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      );
    }

    void _pickImage(String imageTakenType, UserBlog editedBlog) async {
      // picks the image using the camera
      // image is converted to a file class and stored in UserAppSettings Provider
      if (imageTakenType == "camera") {
        final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);
        setState(() {
          pickedImage = File(pickedImageFile?.path as String);
          print(pickedImage);
          _editedUserBlog = editedBlog;
          _editedUserBlog.image_type = "camera";
        });
      }
      else if (imageTakenType == "gallery") {
        final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          pickedImage = File(pickedImageFile?.path as String);
          print(pickedImage);
          _editedUserBlog = editedBlog;
          _editedUserBlog.image_type = "gallery";
        });
      }
    }

    void saveForm(BuildContext ctx, [bool preview = false]) {
      // option to preview blog and to confirm
      if (preview == true) {
        _form.currentState?.save();
        Navigator.of(ctx).push(
            MaterialPageRoute(
                builder: (_) {
                  return BlogScreen(
                    userName: _editedUserBlog.username as String,
                    blogTitle: _editedUserBlog.title as String,
                    blogContent: _editedUserBlog.blogContent as String,
                    preview: true,
                    image_type: _editedUserBlog.image_type as String,
                    image_url: _editedUserBlog.image_url as String,
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
        automaticallyImplyLeading: false,
        title: const Text("Create a Blog!"),
        centerTitle: true,
      ),
      body: Stepper(
        type: StepperType.vertical,
        steps: [
          Step(title: const Text("Blog"),
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
                    const SizedBox(height: 50,),
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
          const Step(
              title: Text("Location"),
              content: Text("Location")
          ),
          Step(
              title: Text("Picture"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (pickedImage!=null) | (pickedInternetImage != null) ? Image(image: pickedInternetImage==null ? FileImage(pickedImage!): pickedInternetImage as ImageProvider, height: 100, width: 100,) : TextButton(onPressed: () {
                    _pickImage("camera", _editedUserBlog);
                  } , child: const Text("Camera?")),
                  if ((pickedImage==null) & (pickedInternetImage == null)) TextButton(onPressed: () {_pickImage("gallery", _editedUserBlog);}, child: const Text("Gallery?")),
                  if ((pickedImage==null) & (pickedInternetImage == null)) TextButton(onPressed: () {_pickImageInternet(context, _editedUserBlog);}, child: const Text("Internet?"),),
                  if ((pickedImage!=null) | (pickedInternetImage != null)) Column(children: [
                    Text("Satisfied?"),
                    Row(
                      children: [
                        TextButton(onPressed: () {
                          setState(() {
                            pickedImage = null;
                            pickedInternetImage = null;
                          });
                        }, child: const Text("No")),
                        TextButton(onPressed: () {}, child: const Text("Yes"),)
                      ],
                    )
                  ],)
                ],
              )
          ),
          Step(
              title: const Text("Confirm"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                      ElevatedButton(
                        onPressed: () {
                          saveForm(context, true);
                        },
                        child: const Text("Preview!"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          saveForm(context);
                        },
                        child: const Text("Confirm Blog"),
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
