import 'package:flutter/material.dart';
import 'package:traverse_1/screens/trip_details/ongoing_trip.dart';
import 'package:traverse_1/screens/trip_details/recent_trips.dart';
import 'package:traverse_1/screens/trip_details/upcoming_trips.dart';

class Containerforhome extends StatelessWidget {
  final int profileid;
  final String imagePath;
  final String areaText;

  const Containerforhome({
    super.key,
    required this.profileid,
    required this.imagePath,
    required this.areaText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            navigateToPage(context);
          },
          child: Center(
            child: Container(
              width: 400,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    right: 20,
                    child: Text(
                      areaText,
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
      ],
    );
  }

  void navigateToPage(BuildContext context) {
    if (areaText == 'Ongoing') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Ongoingtrips(userId: profileid),
      ));
    } else if (areaText == 'Upcoming') {
      // Add navigation logic for another area
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Upcomingtrips(
                userId: profileid,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Recenttrips(
                userId: profileid,
              )));
      // Add navigation logic for other areas
    }
  }
}
