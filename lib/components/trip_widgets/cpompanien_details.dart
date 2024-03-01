import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class Companiendetails extends StatelessWidget {
  const Companiendetails({super.key, required this.trip});
  final Tripmodel trip;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            SizedBox(
              width: screenSize.width * 0.04,
            ),
            const Text(
              'Companions',
              style: TextStyle(color: Colors.amber, fontSize: 28),
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: getCompanions(trip.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(left: 110, top: 20),
                  child: Text(
                    'enjoy the trip',
                    style: TextStyle(color: Colors.amber, fontSize: 26),
                  ),
                );
              } else {
                List<Map<String, dynamic>> companions = snapshot.data!;
                return Row(
                  children: List.generate(
                    companions.length,
                    (index) {
                      final companion = companions[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                              maxRadius: 29,
                              child: Text(
                                companion['name'][0],
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                            Text(
                              companion['name'],
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.amber),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
