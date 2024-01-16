import 'package:flutter/material.dart';
import 'package:traverse_1/custom_widgets/bottomnav_bar.dart';
import 'package:traverse_1/screens/app_details/app_info.dart';
import 'package:traverse_1/screens/intro_screens/sign_or_login.dart';
import 'package:traverse_1/screens/app_details/privacy_policy.dart';
import 'package:traverse_1/screens/trip_adding/trip_date_adding.dart';
import '../../data/functions/profile.dart';
import '../user_details/profile_page.dart';

class Settings extends StatefulWidget {
  final int profileid;
  const Settings({Key? key, required this.profileid}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        'icon': Icons.logout_rounded,
        'text': 'Sign out',
        'action': () {
          // Call the signoutUser function
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sign Out'),
                content: const Text('Do you want to sign out?'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      signoutUser();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Identity()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.amber),
          ),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: Icon(
                item['icon'] as IconData,
                color: Colors.green[40],
              ),
              title: Text(
                item['text'] as String,
                style: const TextStyle(color: Colors.black),
              ),
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
        bottomNavigationBar: Bottomnavbar(
          profileid: widget.profileid,
          navigateToAdd: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDate(profileid: widget.profileid),
              ),
            );
          },
          navigateToHome: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
