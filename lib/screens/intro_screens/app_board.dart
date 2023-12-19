import 'package:flutter/material.dart';
import 'package:traverse_1/screens/intro_screens/identity_page.dart';

class Appboard extends StatelessWidget {
  const Appboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.13,
          ),
          Center(
            child: Container(
              child: const Text(
                '"Welcome to Traverse, your\n ultimated travel companian!\n Plan, budget and document\n your journey effortlessly with \n our app."',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.07,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 42, right: 30),
              child: Container(
                child: const Text(
                  '"Create itineraries, set budgets,\n invite companions, track expenses, and capture \n memories - all in one place."',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.07,
          ),
          Center(
            child: Container(
              child: const Text(
                '"Traverse simplifiers travel\n planning, offfering tools to \n organize and cherish your \n experiences. Lets make every \n trip an unfortateble\n adventure'
                '',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.07,
          ),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size(200, 55),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.yellow
                  // const Color.fromARGB(255, 37, 62, 207),
                  ),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Identity()));
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color.fromARGB(255, 37, 62, 207),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
