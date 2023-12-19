import 'package:flutter/material.dart';
import 'package:traverse_1/data/models/profile/user.dart';
import 'package:traverse_1/screens/app_details/app_info.dart';
import 'package:traverse_1/screens/intro_screens/identity_page.dart';
import 'package:traverse_1/screens/app_details/privacy_policy.dart';
import '../../data/functions/profile.dart';
import '../intro_screens/app_board.dart';
import '../home_page.dart';
import '../trip_adding/trip_add1.dart';
import '../user_details/profile_page.dart';

class Settings extends StatefulWidget {
  final int profileid;
  const Settings({Key? key, required this.profileid}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 0;

  late List<Map<String, dynamic>> items;

  @override
  void initState() {
    super.initState();
    items = createItems(context);
  }

  List<Map<String, dynamic>> createItems(BuildContext context) {
    return [
      {
        'icon': Icons.person,
        'text': 'Account Info',
        'trail': Icons.arrow_forward_ios,
        'action': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Profilepage(),
            ),
          );
        },
      },
      {
        'icon': Icons.lock_outline,
        'text': 'Privacy & policy',
        'trail': Icons.arrow_forward_ios,
        'action': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Privacy(),
            ),
          );
        },
      },
      {
        'icon': Icons.info_outline,
        'text': 'App Info ',
        'trail': Icons.arrow_forward_ios,
        'action': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Appinfo(),
            ),
          );
        },
      },
      {
        'icon': Icons.delete_outline_rounded,
        'text': 'Clear App Data',
        'trail': Icons.arrow_forward_ios,
        'action': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Appboard(),
            ),
          );
        },
      },
      {
        'icon': Icons.logout_rounded,
        'text': 'Sign out',
        'action': () {
          // Call the signoutUser function
          signoutUser();

          // Show a dialog after signing out
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sign Out'),
                content: const Text('You want to sign out'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('cancel'),
                  ),
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();
                      // Navigate to the Identity screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Identity()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );

          // signoutUser();
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Identity()),
          // );
        },
      },
    ];
  }

  void _navigateToHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Homescreen(
          profileid: widget.profileid,
          tripid: widget.profileid,
        ),
      ),
    );
  }

  void _navigateToSearch() {
    if (ModalRoute.of(context)!.settings.name != '/add') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Add1()));
    }
  }
  // void _navigateToSearch() {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add1()));
  //   // Navigator.of(context).popUntil((route) => route.isFirst);
  //   // Add your navigation logic for search here
  //   // For example:
  //   // Navigator.of(context).pushReplacement(
  //   //   MaterialPageRoute(
  //   //     builder: (context) => SearchScreen(profileid: widget.profileid),
  //   //   ),
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: Icon(item['icon'] as IconData),
            title: Text(item['text'] as String),
            // trailing: Icon(item['trail'] as IconData),
            onTap: () {
              if (item.containsKey('action')) {
                final Function action = item['action'];
                action();
              }
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              switch (index) {
                case 0:
                  _navigateToHome();
                  break;
                case 1:
                  _navigateToSearch();
                  break;
                // Add cases for other bottom navigation items if needed
              }
            });
          },
          backgroundColor: Colors.yellow,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
