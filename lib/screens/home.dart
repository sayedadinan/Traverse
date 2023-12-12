import 'package:flutter/material.dart';
// import 'package:traverse_1/screens/add1.dart';
import 'package:traverse_1/screens/add2.dart';
import 'package:traverse_1/screens/profile.dart';
import 'package:traverse_1/screens/settings.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  // Functions associated with each icon
  void _navigateToHome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Homescreen(),
      ),
    );
    // Add your code to navigate to the Home screen or perform related actions
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Profilepage(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/applounch.png'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Add2(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add_box_outlined,
                        size: 80,
                      ),
                    ),
                    const Text('Add your trip now')
                  ],
                ),
              ),
            ),
            // const Text("msmkld")
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;

              // Call different functions based on the selected index
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
