import 'package:flutter/material.dart';
import 'package:traverse_1/screens/intro_screens/sign_up_page.dart';

import 'login_page.dart';

class Identity extends StatelessWidget {
  const Identity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'MAKE',
                style: TextStyle(
                    color: Color.fromARGB(255, 9, 108, 60), fontSize: 50),
              ),
              const Text(
                'IDENTITY',
                style: TextStyle(
                    color: Color.fromARGB(255, 9, 108, 60), fontSize: 50),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(220, 25),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.teal[300],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Signup(),
                    ),
                  );
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Color.fromARGB(255, 3, 70, 37)),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(220, 25),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.teal[300],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(color: Color.fromARGB(255, 3, 70, 37)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
