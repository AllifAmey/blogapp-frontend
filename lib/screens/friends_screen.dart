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

  List<Map<String, dynamic>> friendFeatures = [
    {
    'label': 'Friends',
    'icon': const FaIcon(FontAwesomeIcons.userGroup)
    },
    {
      'label': 'Friend\ninvites',
      'icon': const FaIcon(FontAwesomeIcons.userPlus)
    },
    {
      'label': 'Block\nlist',
      'icon': const FaIcon(FontAwesomeIcons.userShield)
    },
    {
      'label': 'Fellow\nusers',
      'icon': const FaIcon(FontAwesomeIcons.users)
    },
  ];

  List<NavigationRailDestination>? _buildNavigationDestination(List<Map<String, dynamic>> friendFeaturesList) {
    List<NavigationRailDestination> fullFeatureList = [];

    for (var i=0; i<friendFeaturesList.length; i++) {
      fullFeatureList.add(
        NavigationRailDestination(
          icon: friendFeaturesList[i]['icon'],
          label: Text(friendFeaturesList[i]['label']),
        ),
      );
    }
    return fullFeatureList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Friend's list")),
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
            destinations: <NavigationRailDestination>[
              ...?_buildNavigationDestination(friendFeatures)
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
