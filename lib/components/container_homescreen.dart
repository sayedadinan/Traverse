// import 'package:flutter/material.dart';
// import 'package:traverse_1/view/screens/trip_details/ongoing_trip.dart';
// import 'package:traverse_1/view/screens/trip_details/recent_trips.dart';
// import 'package:traverse_1/view/screens/trip_details/upcoming_trips.dart';

// class Containerforhome extends StatelessWidget {
//   final int profileid;
//   final String imagePath;
//   final String areaText;

//   const Containerforhome({
//     super.key,
//     required this.profileid,
//     required this.imagePath,
//     required this.areaText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             navigateToPage(context);
//           },
//           child: Center(
//             child: Container(
//               color: Colors.amber,
//               width: 400,
//               height: 250,
//               // decoration: BoxDecoration(
//               //   image: DecorationImage(
//               //     image: AssetImage(imagePath),
//               //     fit: BoxFit.cover,
//               //   ),
//               //   borderRadius: BorderRadius.circular(10),
//               // ),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 30,
//                     right: 20,
//                     child: Text(
//                       areaText,
//                       style: TextStyle(
//                         fontSize: 48,
//                         fontWeight: FontWeight.bold,
//                         // color: Color.fromRGBO(247, 246, 246, 1),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void navigateToPage(BuildContext context) {
//     if (areaText == 'Ongoing') {
//       Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => Ongoingtrips(userId: profileid),
//       ));
//     } else if (areaText == 'Upcoming') {
//       // Add navigation logic for another area
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => Upcomingtrips(
//                 userId: profileid,
//               )));
//     } else {
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => Recenttrips(
//                 userId: profileid,
//               )));
//       // Add navigation logic for other areas
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:traverse_1/view/screens/trip_details/ongoing_trip.dart';
import 'package:traverse_1/view/screens/trip_details/recent_trips.dart';
import 'package:traverse_1/view/screens/trip_details/upcoming_trips.dart';

class Containerforhome extends StatelessWidget {
  final int profileid;
  final String imagePath;
  final String areaText;

  const Containerforhome({
    Key? key,
    required this.profileid,
    required this.imagePath,
    required this.areaText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToPage(context);
      },
      child: Card(
        elevation: 9,
        child: Container(
          margin: EdgeInsets.all(10),
          width: 350,
          height: 140,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 215, 241, 233),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              // Image area
              Positioned(
                top: 6,
                left: 15,
                child: Container(
                  width: 140,
                  height: 130,
                  child: Lottie.asset(imagePath), // Use provided image path
                ),
              ),
              // Text area
              Positioned(
                top: 30,
                left: 218,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      areaText,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              // Elevated button
              Positioned(
                bottom: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    navigateToPage(context);
                  },
                  child: Text('View Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context) {
    if (areaText == 'Ongoing') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Ongoingtrips(userId: profileid),
      ));
    } else if (areaText == 'Upcoming') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Upcomingtrips(userId: profileid),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Recenttrips(userId: profileid),
      ));
    }
  }
}
