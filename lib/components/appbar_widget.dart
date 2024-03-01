import 'package:flutter/material.dart';
import 'package:traverse_1/view/screens/trip_details/search_trip.dart';

class AppbarWidget extends StatelessWidget {
  final int profileid;
  final String titleText;
  final bool showActions;

  const AppbarWidget({
    Key? key,
    required this.profileid,
    this.titleText = 'TRAVERSE',
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal[200],
      centerTitle: true,
      titleSpacing: 5,
      title: Text(
        titleText,
        style: TextStyle(color: Color.fromARGB(255, 9, 108, 60)),
      ),
      actions: showActions
          ? [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenSearch(
                      userId: profileid,
                    ),
                  ));
                },
                icon: Icon(Icons.search),
              ),
            ]
          : null,
    );
  }
}
