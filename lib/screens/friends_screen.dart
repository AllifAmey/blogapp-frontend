import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

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

    final userInfo = Provider.of<UserProvider>(context);

    List<Widget> _buildCardInfo(List<dynamic> info) {

      List<Widget> infoCards = [];

      for (var i=0; i<info.length; i++) {
        infoCards.add(
            Card(
              child: ListTile(
                title: Text(info[i]['username']),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text("Request friend"),
                ),
              ),
              elevation: 8,
              shadowColor: Colors.green,
              margin: EdgeInsets.all(5),
            )
        );
      }


      return infoCards;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${friendFeatures[_selectedIndex]['label'].replaceAll('\n', " ")}',)),
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
            child: FutureBuilder(
              future: userInfo.getUsersRegistered(),
              builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print(dataSnapshot.data.runtimeType);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Add other users and create blogs together!",
                      style: TextStyle(
                        fontSize: 15
                      ),),
                    ),
                    ..._buildCardInfo(dataSnapshot.data as List<dynamic>)
                  ],
                );
              }
              },
            )
          )
        ],
      ),
    );
  }
}
