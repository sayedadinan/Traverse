import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/view/screens/trip_details/trip_details_page.dart';

class Ongoingtrips extends StatefulWidget {
  final int userId;
  const Ongoingtrips({Key? key, required this.userId}) : super(key: key);

  @override
  State<Ongoingtrips> createState() => _OngoingtripsState();
}

class _OngoingtripsState extends State<Ongoingtrips> {
  late Future<List<Tripmodel>> _futureTrips;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    getalltrip(widget.userId);
    _futureTrips = getOngoingTrips(widget.userId);
    _listener = () {
      setState(() {
        _futureTrips = getOngoingTrips(widget.userId);
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
        backgroundColor: Colors.teal[200],
        centerTitle: true,
        title: const Text(
          'Ongoing Trips',
          style: TextStyle(color: Color.fromARGB(255, 9, 108, 60)),
        ),
      ),
      body: FutureBuilder<List<Tripmodel>>(
        future: _futureTrips,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No ongoing trips available',
                    style: TextStyle(color: Colors.amber, fontSize: 28)));
          } else {
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/traverse image 2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final trip = snapshot.data![index];

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
                            builder: (context) => Tripdetails(trip: trip),
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
