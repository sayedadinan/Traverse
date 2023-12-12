import 'package:flutter/material.dart';
import 'package:traverse_1/screens/appinfo.dart';
import 'package:traverse_1/screens/identity.dart';
import 'package:traverse_1/screens/privacy.dart';
import '../data/functions/profile.dart';
import 'home.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 0;

  late List<Map<String, dynamic>> items; // Declare items late

  @override
  void initState() {
    super.initState();
    // Set items with context when the state is initialized
    items = createItems(context);
  }

  // Function to create items list with context
  List<Map<String, dynamic>> createItems(BuildContext context) {
    return [
      {
        'icon': Icons.person,
        'text': 'Account Info',
        'trail': Icons.arrow_forward_ios,
        'action': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Privacy(),
            ),
          );
          // Implement functionality for 'Account Info' item
          // Add your code to navigate to Account Info screen or perform related actions
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
              builder: (context) => const Privacy(),
            ),
          );
        },
      },
      {
        'icon': Icons.logout_rounded,
        'text': 'Sign out',
        // 'trail': Icons.arrow_forward_ios,
        'action': () {
          signoutUser();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Identity()));
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const Privacy(),
          //   ),
          // );
        },
      },
      // Add other items here
    ];
  }

  void _navigateToHome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Homescreen(),
      ),
    );
  }

  void _navigateToSearch() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Homescreen(),
      ),
    );
  }

  void _navigateToSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  }

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
            trailing: Icon(item['trail']),
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
                case 2:
                  _navigateToSettings();
                  break;
                default:
              }
            });
          },
          backgroundColor: Colors.yellow,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
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
