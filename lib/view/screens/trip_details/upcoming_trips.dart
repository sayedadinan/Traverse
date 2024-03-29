import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/view/screens/trip_details/upcoming_trip_details.dart';

class Upcomingtrips extends StatefulWidget {
  final int userId;

  const Upcomingtrips({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<Upcomingtrips> createState() => _UpcomingtripsState();
}

class _UpcomingtripsState extends State<Upcomingtrips> {
  late Future<List<Tripmodel>> _futureTrips;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    getalltrip(widget.userId);
    _futureTrips = getUpcomingTrip(widget.userId);
    _listener = () {
      setState(() {
        _futureTrips = getUpcomingTrip(widget.userId);
      });
    };
    tripdatas.addListener(_listener);
  }

  @override
  void dispose() {
    tripdatas.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[200],
        title: const Text(
          'Upcoming Trips',
          style: TextStyle(
              color: Color.fromARGB(255, 9, 108, 60),
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/pexels-jarod-lovekamp-2404444.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          FutureBuilder<List<Tripmodel>>(
            future: _futureTrips,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No upcoming trips available',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final trip = snapshot.data![index];
                    // String firstImagePath =
                    //     trip.imagePaths.isNotEmpty ? trip.imagePaths.first : '';
                    // File firstImageFile = File(firstImagePath);
                    // ImageProvider firstImageProvider =
                    //     FileImage(firstImageFile);
                    return Card(
                      color: const Color.fromARGB(255, 214, 218, 214),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Upcomingdetails(trip: trip),
                          ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                              // leading: CircleAvatar(
                              //   radius: 28,
                              //   backgroundImage: firstImageProvider,
                              // ),
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
        ],
      ),
    );
  }
}
