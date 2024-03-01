import 'package:flutter/material.dart';
import 'package:traverse_1/components/bottomnav_bar.dart';
import 'package:traverse_1/components/container_homescreen.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/view/screens/settings_screen/settings_page.dart';
import 'package:traverse_1/view/screens/trip_adding/trip_date_adding.dart';
import 'package:traverse_1/view/screens/trip_details/search_trip.dart';
import '../../data/functions/profile.dart';

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
              Containerforhome(
                areaText: 'Ongoing',
                imagePath: 'assets/Animation - 1708963245059.json',
                profileid: widget.profileid,
              ),
              const SizedBox(
                height: 10,
              ),
              Containerforhome(
                areaText: 'Upcoming',
                imagePath: 'assets/secondanimation.json',
                profileid: widget.profileid,
              ),
              const SizedBox(
                height: 10,
              ),
              Containerforhome(
                areaText: 'Previous',
                imagePath: 'assets/Animation - 1708881817289.json',
                profileid: widget.profileid,
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
