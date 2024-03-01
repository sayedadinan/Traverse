// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:traverse_1/data/models/profile/user.dart';
// import 'package:traverse_1/view/screens/home_page.dart';
// import 'package:traverse_1/view/screens/intro_screens/sign_or_login.dart';
// import '../../../data/functions/profile.dart';

// class Splashscreen extends StatefulWidget {
//   const Splashscreen({super.key});

//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen> {
//   @override
//   void initState() {
//     gotoLogin();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: Stack(
//               children: [
//                 Text('ad'),
//                 Lottie.asset('assets/Animation - 1708881817289.json'),

//                 // SizedBox(),
//                 // Text(
//                 //   'Shall We Go',
//                 //   style: TextStyle(
//                 //     fontSize: 40,
//                 //     color: Color.fromARGB(255, 52, 102, 79),
//                 //     fontWeight: FontWeight.bold,
//                 //   ),
//                 // )
//                 // Container(
//                 //   decoration: const BoxDecoration(
//                 //     image: DecorationImage(
//                 //       image: AssetImage('assets/traverse splash screen.jpg'),
//                 //       fit: BoxFit.fill,
//                 //     ),
//                 //   ),
//                 // ),
//                 // SizedBox(
//                 //   width: double.maxFinite,
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.center,
//                 //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //     children: [
//                 //       Text(
//                 //         'Shall We Go',
//                 //         style: TextStyle(
//                 //           fontSize: 40,
//                 //           color: Color.fromARGB(255, 52, 102, 79),
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //       ),
//                 //       SizedBox(),
//                 //       SizedBox()
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> gotoLogin() async {
//     await Future.delayed(const Duration(seconds: 5));
//     Profile? userData = await getUserLogged();

//     if (userData != null) {
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => Homescreen(
//             profileid: userData.id!,
//           ),
//         ),
//         (route) => false,
//       );
//     } else {
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => const Identity(),
//         ),
//         (route) => false,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:traverse_1/data/models/profile/user.dart';
import 'package:traverse_1/view/screens/home_page.dart';
import 'package:traverse_1/view/screens/intro_screens/sign_or_login.dart';
import '../../../data/functions/profile.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Animation - 1708881817289.json'),
            SizedBox(height: 20),
            Text(
              'Traverse',
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 52, 102, 79),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 5));
    Profile? userData = await getUserLogged();

    if (userData != null) {
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
