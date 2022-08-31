import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/user_app_setting_provider.dart';

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

  List<NavigationRailDestination>? _buildNavigationDestination(List<Map<String, dynamic>> friendFeaturesList,) {
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
    final userProfilePicture = Provider.of<UserAppSettingsProvider>(context);


    
    Widget _buildFriendScreenTitle(String title) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,
          style: TextStyle(
              fontSize: 15
          ),),
      );
    }

    List<Widget>? _buildFellowUsersButtons(String user_relation_status, String username) {
      // change widget display dependant on user status
      if (user_relation_status=="neutral") {
        return [TextButton(
          child: const Text("Request"),
          onPressed: () {
            // send friend request
            userInfo.sendFriendRequest(userInfo.currentUsername, username);
          },
        ),
          TextButton(
            child: const Text("Block"),
            onPressed: () {
              //send block request
              userInfo.sendBlockUserRequest(userInfo.currentUsername, username);
            },
          )
        ];
      } else if (user_relation_status=="friend") {
        return [const Text("Friend",
        style: TextStyle(
          fontSize: 14,
        ),
        )];
      } else if (user_relation_status=="blocked") {
        return [const Text("Blocked",
          style: TextStyle(
            fontSize: 14,
          ),
        )];
      }
      return null;
    }

    List<Widget> _buildCardInfo(BuildContext ctx, List<dynamic> info, int screenIndex) {

      List<Widget> infoCards = [];

      if (screenIndex == 0) {
        // Friends
        infoCards.add(_buildFriendScreenTitle("Message your friends, get to know them!"));
        // expected json file 'friend' and 'friend_status

        if (info[0]['message'] == 'You have no friends.') {
          infoCards.add(Center(child: Text(info[0]['message'])));
        } else {
          for (var i=0; i<info.length; i++) {
            infoCards.add(
                Card(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(info[i]['friend']),
                        TextButton(onPressed: () {
                          userInfo.getFriendId(userInfo.currentUsername, info[i]['friend'])?.then((data) => {
                            userInfo.unFriendRequest(userInfo.currentUsername, info[i]['friend'], data[0]['id'])
                          });
                        }, child: Text("Unfriend"))
                      ],
                    )
                )
            );
          }
        }

      } else if (screenIndex == 1) {
        // Friends Invites
        infoCards.add(_buildFriendScreenTitle("Friend request by others. Accept requests to become friends"));

        for (var i=0; i<info.length; i++) {
          if (info[i]['user_relation_status'] == "request") {
            infoCards.add(
                Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        info[i]['has_image'] == "Yes" ? FutureBuilder(
                          future: userProfilePicture.grabImage(info[i]['username'], true),
                          builder: (ctx, dataSnapShot) {
                            return CircleAvatar(
                              backgroundImage: userProfilePicture.tempImage?.image,
                            );
                          },
                        ) : CircleAvatar(
                          backgroundImage: AssetImage('assets/images/default_user_profile_img.png'),
                        ),
                        Text('${info[i]['username']} wants to be your friend',
                        style: TextStyle(
                          fontSize: 10
                        ),),
                        TextButton(onPressed: (){
                          userInfo.getFriendId(userInfo.currentUsername, info[i]['username'])?.then(
                                  (data){
                                    /*
                                    {
                                      "username": "Jamie",
                                    "friend_requester": "Mickey"
                                    }*/
                            userInfo.acceptFriendRequest(userInfo.currentUsername, info[i]['username'], data[0]['id']);
                          });
                        },child: Text("Accept"),)
                      ],
                    )
                )
            );
          }
        }


      } else if (screenIndex == 2) {
        // Block List
        infoCards.add(_buildFriendScreenTitle("Blocked users can't message you or send friend requests!"));
        // expected json file 'message' for empty, 'blockedUser' with username
        if (info[0]['message'] =='You have no blocked users') {
          infoCards.add(Center(child: Text(info[0]['message'])));
        } else {
          for (var i=0; i<info.length; i++) {
            infoCards.add(
                Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(info[i]['blockedUser']),
                        TextButton(onPressed: () {
                          userInfo.getBlockId(userInfo.currentUsername, info[i]['blockedUser'])?.then((data) => {
                            userInfo.unBlockRequest(userInfo.currentUsername, info[i]['blockedUser'], data[0]['id'])
                          });
                        }, child: Text("Unblock"))
                      ],
                    )
                )
            );
          }
        }

      } else if (screenIndex == 3) {
        // Fellow Users#
        // info[i]['has_image'] == "Yes" ? FutureBuilder(
        infoCards.add(const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Add other users and create blogs together!",
            style: TextStyle(
                fontSize: 15
            ),),
        ),);
        for (var i=0; i<info.length; i++) {
          infoCards.add(
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      info[i]['has_image'] == "Yes" ? FutureBuilder(
                        future: userProfilePicture.grabImage(info[i]['username'], true),
                        builder: (ctx, dataSnapShot) {
                          return CircleAvatar(
                            backgroundImage: userProfilePicture.tempImage?.image,
                          );
                        },
                      ) : CircleAvatar(
                        backgroundImage: AssetImage('assets/images/default_user_profile_img.png'),
                      ),
                    Text(info[i]['username']),
                    ...?_buildFellowUsersButtons(info[i]['user_relation_status'], info[i]['username'])
                  ],
                )
              )
          );
        }
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
              future: _selectedIndex == 0
                  ? userInfo.getFriendList(userInfo.currentUsername)
                  : (_selectedIndex == 1) | (_selectedIndex == 3)
                  ? userInfo.getUsersRegistered(userInfo.currentUsername)
                  : userInfo.getBlockedList(userInfo.currentUsername),
              builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print(_selectedIndex);
                print(dataSnapshot.data);
                print(dataSnapshot.data.runtimeType);
                return Column(
                  children: [
                    ..._buildCardInfo(context, dataSnapshot.data as List<dynamic>, _selectedIndex)
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
