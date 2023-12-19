import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/screens/user_details/profile_page.dart';
import 'package:traverse_1/screens/app_details/settings_page.dart';
import '../data/functions/profile.dart';
import 'trip_adding/trip_add1.dart';
import 'trip_details/all_details.dart';

class Homescreen extends StatefulWidget {
  final int profileid;
  final int tripid;
  const Homescreen({Key? key, required this.profileid, required this.tripid})
      : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  void _navigateToHome() {}

  void _navigateToAdd() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add1()));
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
    getprofile(widget.profileid);
    getalltrip(widget.tripid);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 58, 239),
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
                  radius: 20, backgroundColor: Colors.transparent,
                  // backgroundImage:
                  //      != null && File(value.first.imagex!).existsSync()
                  //         ? FileImage(File(value.first.imagex))
                  //             as ImageProvider<Object>?
                  //         : const AssetImage(
                  //             'assets/user.png',
                  //           ),
                  backgroundImage: AssetImage('assets/user.png'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => All()));
                // Navigate to the next page here
              },
              child: Center(
                child: Container(
                  width: 400,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 215, 71),
                    borderRadius: BorderRadius.circular(
                        10), // Adjust border radius as needed
                  ),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.1, -0.21),
                        child: Padding(
                          padding: EdgeInsets.only(right: 28.0),
                          child: Text(
                            'On Going',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => All()));
                // Navigate to the next page here
              },
              child: Center(
                child: Container(
                  width: 400,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 215, 71),
                    borderRadius: BorderRadius.circular(
                        10), // Adjust border radius as needed
                  ),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.1, -0.21),
                        child: Padding(
                          padding: EdgeInsets.only(right: 28.0),
                          child: Text(
                            'Up Coming',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => All()));
                // Navigate to the next page here
              },
              child: Center(
                child: Container(
                  width: 400,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 215, 71),
                    borderRadius: BorderRadius.circular(
                        10), // Adjust border radius as needed
                  ),
                  child: const Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.1, -0.21),
                        child: Padding(
                          padding: EdgeInsets.only(right: 28.0),
                          child: Text(
                            'Recents',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         IconButton(
            //           onPressed: () {
            //             Navigator.of(context).push(
            //               MaterialPageRoute(
            //                 builder: (context) => Add1(),
            //               ),
            //             );
            //           },
            //           icon: const Icon(
            //             Icons.add_box_outlined,
            //             size: 80,
            //           ),
            //         ),
            //         const Text('Add your trip now')
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
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
                  _navigateToAdd();
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
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
