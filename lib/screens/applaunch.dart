import 'package:flutter/material.dart';
import 'package:traverse_1/screens/signup.dart';

class Applaunch extends StatelessWidget {
  const Applaunch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 62, 207),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'START OUR TRIP',
              style: TextStyle(color: Colors.yellow, fontSize: 40),
            ),
            const Image(
              width: 270,
              image: AssetImage('assets/applounch.png'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  const Size(350, 25),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.amber),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Signup()));
              },
              child: const Text('Get started'),
            ),
          ],
        ),
      )),
    );
  }
}
