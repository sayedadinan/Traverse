import 'package:flutter/material.dart';
import 'package:traverse_1/custom_widgets/bottomnav_bar.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/screens/app_details/settings_page.dart';
import 'package:traverse_1/screens/trip_adding/trip_date_adding.dart';
import 'package:traverse_1/screens/trip_details/ongoing_trip.dart';
import 'package:traverse_1/screens/trip_details/recent_trips.dart';
import 'package:traverse_1/screens/trip_details/search_trip.dart';
import 'package:traverse_1/screens/trip_details/upcoming_trips.dart';
import '../data/functions/profile.dart';

class Homescreen extends StatefulWidget {
  final int profileid;

  const Homescreen({
    Key? key,
    required this.profileid,
  }) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    getprofile(widget.profileid);
    getalltrip(widget.profileid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        centerTitle: true,
        titleSpacing: 5,
        title: const Text(
          'TRAVERSE',
          style: TextStyle(color: Color.fromARGB(255, 9, 108, 60)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenSearch(
                          userId: widget.profileid,
                        )));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 13, right: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        Ongoingtrips(userId: widget.profileid),
                  ));
                  // Navigate to the next page here
                },
                child: Center(
                  child: Container(
                    width: 400,
                    height: 210,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/traverse image 2.jpg'),
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Stack(
                      children: [
                        Positioned(
                          top: 30,
                          right: 20,
                          child: Text(
                            'Ongoing',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(247, 246, 246, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Upcomingtrips(
                      userId: widget.profileid,
                    ),
                  ));
                  // Navigate to the next page here
                },
                child: Center(
                  child: Container(
                    width: 400,
                    height: 210,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/traverse image.jpg'),
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Stack(
                      children: [
                        Positioned(
                          top: 30,
                          right: 20,
                          child: Text(
                            'Up Coming',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Recenttrips(
                      userId: widget.profileid,
                    ),
                  ));
                  // Navigate to the next page here
                },
                child: Center(
                  child: Container(
                    width: 400,
                    height: 210,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/traverse 8.jpg'),
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Stack(
                      children: [
                        Positioned(
                          top: 30,
                          right: 20,
                          child: Text(
                            'Previous ',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottomnavbar(
        profileid: widget.profileid,
        navigateToAdd: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDate(
                profileid: widget.profileid,
              ),
            ),
          );
        },
        navigateToSettings: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Settings(
                profileid: widget.profileid,
              ),
            ),
          );
        },
      ),
    );
  }
}
