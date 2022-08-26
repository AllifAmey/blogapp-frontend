import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  /// Screen to show current friends and current users in the system.
  /// Main Screen holds all the friends
  /// To the left holds a Navigation rail
  /// Navigation Rails contains users online, block list, friend request,
  /// friends page.
  /// Upon entering one of the page the relevant page will be highlighted on the,
  /// Navigation Rails widget.

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Friend's list")),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(

            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: FaIcon(FontAwesomeIcons.userGroup),
                label: Text('Friends'),
              ),
              NavigationRailDestination(
                icon: FaIcon(FontAwesomeIcons.userPlus),
                label: Text('Friend\ninvites', textAlign: TextAlign.center,),
              ),
              NavigationRailDestination(
                icon: FaIcon(FontAwesomeIcons.userShield),
                label: Text('Block\nlist'),
              ),
              NavigationRailDestination(
                icon: FaIcon(FontAwesomeIcons.users),
                label: Text('Fellow\nusers'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: Text('selectedIndex: $_selectedIndex'),
            ),
          )
        ],
      ),
    );
  }
}
