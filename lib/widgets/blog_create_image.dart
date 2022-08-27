import 'package:flutter/material.dart';
import 'dart:io';

class BlogCreateImage extends StatelessWidget {
  /// Takes 2 types of images
  /// Creates image dependant on type.

  File? imageCameraGallery;
  NetworkImage? imageInternet;
  double? height;
  double? width;

  BlogCreateImage(
      {Key? key,
      required this.imageCameraGallery,
      required this.imageInternet,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: imageCameraGallery != null
          ? FileImage(imageCameraGallery!)
          : imageInternet as ImageProvider,
      width: width,
      height: height,
    );
  }
}
