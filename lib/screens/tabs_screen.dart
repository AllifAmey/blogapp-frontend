import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import './blog_main_screen.dart';
import './blog_create_form_screen.dart';
import './account_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs/';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  final List<Map<String, Object>> _pages = [
    {
      'page': BlogMain(),
      'title': 'Blogs from users'
    },
    {
      'page': BlogCreateForm(),
      'title': 'Create a blog!'
    },
    {
      'page': Account(),
      'title': 'Account Page'
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.blog),
            label: "Blogs",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.pen),
            label: "Create blog",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
