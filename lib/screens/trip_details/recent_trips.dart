import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/trip_details_page.dart';

class Recenttrips extends StatefulWidget {
  final int userId;

  const Recenttrips({Key? key, required this.userId}) : super(key: key);

  @override
  State<Recenttrips> createState() => _UpcomingtripsState();
}

class _UpcomingtripsState extends State<Recenttrips> {
  late Future<List<Tripmodel>> _futureTrips;

  @override
  void initState() {
    super.initState();
    _futureTrips = getRecentTrip(
      widget.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Recent Trips',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 249, 249),
            fontSize: 28,
          ),
        ),
      ),
      //... Your scaffold content remains the same

      body: FutureBuilder<List<Tripmodel>>(
        future: _futureTrips,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Loading indicator
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'), // Error message
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Recent trips available',
                style: TextStyle(color: Colors.amber, fontSize: 28),
              ),
            );
          } else {
            // Display your ListView.builder with retrieved trips
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final trip = snapshot.data![index];
                // Build your UI for each trip here
                return Card(
                  color: Colors.green[200],
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Tripdetails1(trip: trip),
                      ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            trip.tripname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                              color: Colors.green[800],
                            ),
                          ),
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
          }
        },
      ),
    );
  }
}
