import 'package:flutter/material.dart';

import 'data/functions/profile.dart';
// import 'screens/identity.dart';
import 'screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeProfileDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 37, 62, 207),
        ),
        useMaterial3: true,
      ),
      home: const Splashscreen(),
    );
  }
}
