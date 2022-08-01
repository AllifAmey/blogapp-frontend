import 'package:flutter/material.dart';

class Blog extends StatelessWidget {

  String userName;
  String blogTitle;
  String blogContent;

  Blog({
    required this.userName,
    required this.blogTitle,
    required this.blogContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.userName),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(this.blogTitle),
            SizedBox(
              height: 100,
            ),
            Text(this.blogContent),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.pop(context);
        },
        child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Back",),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
