import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile page'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage('assets/car traverse.png'),
              ),
            ),
            Text('Name '),
            Text('Name '),
            Text('Name '),
            Text('Name ')
          ],
        ),
      ),
    );
  }
}
