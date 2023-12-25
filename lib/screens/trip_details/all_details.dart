import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'trip_details_page.dart';

class Alldetails extends StatelessWidget {
  final int userId;
  const Alldetails({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    getalltrip(userId);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'All Trip Data',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 249, 249), fontSize: 25),
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
                color: Colors.green[200],
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Tripdetails1(
                              trip: trip,
                            )));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(trip.tripname,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 27,
                                color: Colors.green[800])),
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
