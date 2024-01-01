import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class Companiendetails extends StatelessWidget {
  const Companiendetails({super.key, required this.trip});
  final Tripmodel trip;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              'Companions',
              style: TextStyle(color: Colors.amber, fontSize: 28),
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: getCompanions(
                trip.id!), // Assuming widget.trip.id is the trip ID
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Display a loading indicator while fetching data
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Display an error if fetching data fails
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(left: 120, top: 20),
                  child: Text(
                    'Your going alone .',
                    style: TextStyle(color: Colors.amber, fontSize: 30),
                  ),
                ); // Display a message if no data is available
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
                                companion['name'][
                                    0], // Assuming the name is stored in a field called 'name'
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 20),
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
