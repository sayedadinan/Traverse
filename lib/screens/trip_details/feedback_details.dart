import 'package:flutter/material.dart';
import 'dart:typed_data';

class Feedbackshowing extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Feedbackshowing({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getFeedbackFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> feedbackList = snapshot.data ?? [];

            if (feedbackList.isEmpty) {
              return const Center(child: Text('No feedback available'));
            } else {
              String feedbackText = feedbackList[0]['feedbackText'] ?? '';
              String feedbackDate = feedbackList[0]['feedbackDate'] ?? '';
              Uint8List imageBytes =
                  feedbackList[0]['imageBytes'] ?? Uint8List(0);

              return Column(
                children: [
                  Container(
                    width: 200,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageBytes.isNotEmpty
                            ? MemoryImage(imageBytes) as ImageProvider
                            : const AssetImage('assets/traverse 8.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Date: $feedbackDate',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Feedback: $feedbackText',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getFeedbackFromDatabase() async {
    return [];
  }
}
