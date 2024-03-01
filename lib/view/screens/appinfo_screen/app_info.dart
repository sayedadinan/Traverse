import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class Appinfo extends StatelessWidget {
  const Appinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lottie.asset('assets/testanimation.json'),
            Text(
              'Traverse',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Version: 1.0',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
            ),
            SizedBox(),
            Text(
              '''Traverse is your ultimate travel companion, designed to make trip planning a breeze. Organize your journeys with ease by inputting travel dates, destinations, companions, and even attach media to capture your memorable moments.''',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
