import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/functions/tripdata.dart';

import 'data/functions/profile.dart';
// import 'screens/identity.dart';
import 'screens/intro_screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeProfileDB();
  initializationtrip();
  initproperties();
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
          seedColor: Color.fromARGB(255, 140, 195, 169),
        ),
        useMaterial3: true,
      ),
      home: const Splashscreen(),
    );
  }
}
