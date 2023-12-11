import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & policy'),
      ),
      body: const Column(
        children: [
          Text(
            'Main advantage',
            style: TextStyle(fontSize: 20),
          ),
          Text(''),
        ],
      ),
    );
  }
}
