import 'package:flutter/material.dart';
import 'package:traverse_1/screens/app_details/settings_page.dart';
import 'package:traverse_1/screens/trip_adding/trip_date.dart';

class Bottomnavbar extends StatefulWidget {
  final int profileid;
  const Bottomnavbar({super.key, required this.profileid});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _selectedIndex = 0;
  bool selected = false;
  void _navigateToHome() {}

  void _navigateToAdd() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Add1(
              profileid: widget.profileid,
            )));
  }

  void _navigateToSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Settings(profileid: widget.profileid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BottomNavigationBar(
          elevation: 12,
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
                  _navigateToAdd();
                  break;
                case 2:
                  _navigateToSettings();
                  break;
                default:
              }
            });
          },
          // backgroundColor: Color.fromARGB(255, 212, 153, 230),
          backgroundColor: Colors.teal[200],
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
