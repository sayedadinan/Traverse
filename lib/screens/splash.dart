import 'package:flutter/material.dart';
import 'package:traverse_1/data/models/profile/user.dart';
import 'package:traverse_1/screens/home.dart';
import 'package:traverse_1/screens/identity.dart';
import '../data/functions/profile.dart';

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
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 62, 207),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 295,
                image: AssetImage('assets/car traverse.png'),
              ),
              Text(
                'Lets goo...',
                style: TextStyle(fontSize: 50, color: Colors.yellow),
              ),
            ],
          ),
        ),
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
          builder: (context) => const Homescreen(),
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
