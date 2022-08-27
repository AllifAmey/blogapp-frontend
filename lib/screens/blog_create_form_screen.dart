import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../providers/user_provider.dart';
import '../providers/user_blog_provider.dart';
import '../widgets/blog_create_image.dart';
import './blog_individual_screen.dart';
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
  String imageType = 'none';
  String? imageURL;
  int _currentStep = 0;
  File? pickedImage;
  NetworkImage? pickedInternetImage;
  bool imageFromInternet = false;
  TextEditingController urlImage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userBlogUnconfirmed = Provider.of<UserBlogProvider>(context);
    final user = Provider.of<UserProvider>(context);
    UserBlog _editedUserBlog = UserBlog(
      username: user.getUserId().toString(),
      title: blogTitle,
      blogContent: blogContent,
      image_type: imageType,
      image_url: imageURL,
    );

    void blogConfirmationPage(
      BuildContext ctx,
      String? imageType,
      String? imageUrl,
    ) {
      // Last screen the user sees before publishing the blog.
      // once Create blog button is pressed user can not go back to edit blog.
      showModalBottomSheet(
        elevation: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: ctx,
        builder: (_) {
          return Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Are you sure?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("Go back")),
                      ElevatedButton(
                          onPressed: () {
                            userBlogUnconfirmed
                                .createBlog(
                              _editedUserBlog,
                              imageType,
                              imageUrl,
                            )
                                .then((_) {
                              if (imageType != "internet") {
                                userBlogUnconfirmed.postBlogImage(pickedImage!,
                                    _editedUserBlog.title as String);
                              }
                            });
                            Navigator.of(context)
                                .pushReplacementNamed(TabsScreen.routeName);
                          },
                          child: const Text("Create Blog")),
                    ],
                  ),
                ],
              ));
        },
      );
    }

    void _pickImageInternetPopup(BuildContext ctx, UserBlog editedBlog) async {
      // A pop up that gives the option for the user to type URL and grab image,
      // from internet.
      showDialog(
          context: ctx,
          builder: (_) => Container(
                height: 500,
                child: AlertDialog(
                  title: const Text("Image from Internet"),
                  content: Container(
                    height: 200,
                    child: Column(
                      children: [
                        TextField(
                          controller: urlImage,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Type url"),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  pickedInternetImage =
                                      NetworkImage(urlImage.text);
                                  _editedUserBlog = editedBlog;
                                  imageType = "internet";
                                  imageURL = urlImage.text;
                                  Navigator.pop(ctx);
                                });
                              },
                              child: const Text("Confirm"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text("Go back"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
    }

    void _pickImage(String imageTakenType, UserBlog editedBlog) async {
      // picks the image using the camera
      // image is converted to a file class and stored in UserAppSettings Provider
      if (imageTakenType == "camera") {
        final pickedImageFile =
            await ImagePicker().pickImage(source: ImageSource.camera);
        setState(() {
          pickedImage = File(pickedImageFile?.path as String);
          print(pickedImage);
          _editedUserBlog = editedBlog;
          imageType = "camera";
        });
      } else if (imageTakenType == "gallery") {
        final pickedImageFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          pickedImage = File(pickedImageFile?.path as String);
          print(pickedImage);

          imageType = "gallery";
        });
      }
    }

    List<Widget>? _buildBlogPictureForm(
        File? pickedImageInput, NetworkImage? pickedInternetImageInput, ) {
      // create blog picture form to make code neater.
      // from the list of widgets then use the seperator operator to display it.
      // pickedImage!=null) | (pickedInternetImage != null)
      // pickedImage
      if ((pickedImageInput == null) & (pickedInternetImageInput==null)) {
        // If no image is picked represent them the options
        List<Widget> noImagePicked = [
          TextButton(
              onPressed: () {
                _pickImage("camera", _editedUserBlog);
              },
              child: const Text("Camera?")),
          TextButton(
              onPressed: () {
                _pickImage("gallery", _editedUserBlog);
              },
              child: const Text("Gallery?")),
          TextButton(
            onPressed: () {
              _pickImageInternetPopup(context, _editedUserBlog);
            },
            child: const Text("Internet?"),
          ),
        ];
        return noImagePicked;
      };
      if ((pickedImageInput != null)) {
        // if image picked is not from internet present image
        // and options to change
        List<Widget> imagePickedCameraGallery = [
          BlogCreateImage(
            imageCameraGallery: pickedImageInput,
            imageInternet: null,
            height: 100,
            width: 100,
          ),
          Column(
            children: [
              const Text("Satisfied?"),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          pickedImage = null;
                          pickedInternetImage = null;
                        });
                      },
                      child: const Text("No?")),

                ],
              )
            ],
          ),
        ];
        return imagePickedCameraGallery;
      }
      if ((pickedInternetImageInput != null)) {
        // if image picked is from internet present image
        // and options to change
        List<Widget> imagePickedInternet = [
          BlogCreateImage(
            imageCameraGallery: null,
            imageInternet: pickedInternetImageInput,
            height: 100,
            width: 100,
          ),
          Column(
            children: [
              const Text("Satisfied?"),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          pickedImage = null;
                          pickedInternetImage = null;
                        });
                      },
                      child: const Text("No?")),
                ],
              )
            ],
          ),
        ] ;
        return imagePickedInternet;
      }
      return null;
    }

    void saveForm(BuildContext ctx, String imageType, String? imageUrl,
        [bool preview = false]) {
      // option to preview blog and to confirm
      if (preview == true) {
        // All blog information will be saved and inputted to BlogScreen to show,
        // the users what it would look like if they confirm blog.
        _form.currentState?.save();
        Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
          return BlogScreen(
            userName: _editedUserBlog.username as String,
            blogTitle: _editedUserBlog.title as String,
            blogContent: _editedUserBlog.blogContent as String,
            preview: true,
            imageType: imageType,
            imageUrl: imageUrl,
            imageFile: pickedImage,
          );
        }));
      } else {
        // This confirms a desire o publish would-be blog.
        // another page is shown to confirm a second time in case they chance,
        // their mind.
        _form.currentState?.save();
        blogConfirmationPage(ctx, imageType, imageUrl);
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
          Step(
            title: const Text("Blog"),
            content: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
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
                          _editedUserBlog = UserBlog(
                              username: user.getUserId().toString(),
                              title: value,
                              blogContent: _editedUserBlog.blogContent);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
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
                        onChanged: (value) {},
                        onSaved: (value) {
                          _editedUserBlog = UserBlog(
                              username: user.getUserId().toString(),
                              title: _editedUserBlog.title,
                              blogContent: value);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Step(title: Text("Location"), content: Text("Location")),
          Step(
              title: const Text("Picture"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...?_buildBlogPictureForm(
                      pickedImage,
                      pickedInternetImage,)
                ],
              )),
          Step(
              title: const Text("Confirm"),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        saveForm(context, imageType, imageURL, true);
                      },
                      child: const Text("Preview!"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveForm(context, imageType, imageURL);
                      },
                      child: const Text("Confirm Blog"),
                    ),
                  ])),
        ],
        onStepTapped: (int newIndex) {
          setState(() {
            _currentStep:
            newIndex;
          });
        },
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep != 3) {
            setState(() {
              _currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep != 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
      ),
    );
  }
}
