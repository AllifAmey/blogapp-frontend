import 'package:flutter/material.dart';
import './location_controller.dart';
import 'package:get/get.dart';
import 'map_screen.dart';

class SelectLocationBlogScreen extends StatefulWidget {
  const SelectLocationBlogScreen({Key? key}) : super(key: key);

  @override
  State<SelectLocationBlogScreen> createState() =>
      _SelectLocationBlogScreenState();
}

class _SelectLocationBlogScreenState extends State<SelectLocationBlogScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: MapScreen());
  }
}
