import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './blog_main_screen.dart';
import './blog_create_form_screen.dart';
import './account_profile_screen.dart';
import './friends_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs/';
  int pageNumDefault;

  TabsScreen({Key? key, required this.pageNumDefault}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  _TabsScreenState();

  final List<Map<String, Object>> _pages = [
    {'page': const BlogMain(), 'title': 'Blogs from users'},
    {'page': const BlogCreateForm(), 'title': 'Create a blog!'},
    {'page': const FriendScreen(), 'title': 'Friends Page'},
    {'page': const Account(), 'title': 'Account Page'},
  ];

  @override
  Widget build(BuildContext context) {
    int _selectedPageIndex = widget.pageNumDefault;
    print(widget.pageNumDefault);
    void _selectPage(int index) {
      setState(() {
        widget.pageNumDefault = index;
      });
    }

    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        onTap: _selectPage,
        currentIndex: widget.pageNumDefault,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.blog),
            label: "Blogs",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.pen),
            label: "Create blog",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.peopleGroup),
            label: "Friends",
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
