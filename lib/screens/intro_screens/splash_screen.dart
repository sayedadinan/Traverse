import 'package:flutter/material.dart';
import 'package:traverse_1/data/models/profile/user.dart';
// import 'package:traverse_1/screens/intro_screens/app_board.dart';
import 'package:traverse_1/screens/home_page.dart';
import 'package:traverse_1/screens/intro_screens/identity_page.dart';
import '../../data/functions/profile.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/traverse splash screen.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Positioned(
            top: 180, // Adjust the top position as needed
            left: 102, // Adjust the left position as needed
            child: Text(
              'Shall We Go',
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 52, 102, 79),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Profile? userData = await getUserLogged();

    if (userData != null) {
      // User is logged in, navigate to bottomNavigationBar
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Homescreen(
            profileid: userData.id!,
          ),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Identity(),
        ),
        (route) => false,
      );
    }
  }
}
