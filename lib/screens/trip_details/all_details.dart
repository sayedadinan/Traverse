import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'trip_details_page.dart';

class All extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 58, 239),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'All Trip Data',
          style: TextStyle(color: Colors.amber, fontSize: 30),
        ),
      ),
      body: ValueListenableBuilder<List<Tripmodel>>(
        valueListenable: tripdatas,
        builder: (context, trips, _) {
          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Tripdetails1(trip: trip)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(12),
                      //   child: Image.asset(
                      //     'assets/user.png',
                      //     fit: BoxFit.cover,
                      //     height: 60,
                      //   ),
                      // ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(trip.tripname,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 27)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              'Destination: ${trip.destination}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
