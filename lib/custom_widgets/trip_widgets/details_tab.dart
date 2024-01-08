import 'package:flutter/material.dart';
import 'package:traverse_1/custom_widgets/trip_widgets/cpompanien_details.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class Detailstab extends StatelessWidget {
  const Detailstab({super.key, required this.trip});
  final Tripmodel trip;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Starting date',
              style: TextStyle(fontSize: 26, color: Colors.amber),
            ),
            SizedBox(
              width: screenSize.width * 0.15,
            ),
            const Text(
              'Ending date',
              style: TextStyle(fontSize: 26, color: Colors.amber),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 27),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                trip.startingDate,
                style: const TextStyle(fontSize: 22, color: Colors.amber),
              ),
              SizedBox(
                width: screenSize.width * 0.15,
              ),
              Text(
                trip.endingDate,
                style: const TextStyle(fontSize: 22, color: Colors.amber),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 39),
          child: Container(
            width: screenSize.width * 0.8,
            height: screenSize.height * 0.3,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 59, 58, 54),
                border: Border.all(color: Colors.amber),
                borderRadius: BorderRadius.circular(19)),
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                const Text(
                  'Trip ',
                  style: TextStyle(color: Colors.amber, fontSize: 22),
                ),
                const Text(
                  'Budget',
                  style: TextStyle(color: Colors.amber, fontSize: 23),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Text(
                  '₹  ${trip.budget.toString()}',
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<int>(
                      future: getTotalExpense(trip.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Text('No data available');
                        } else {
                          final total = snapshot.data;
                          return Text(
                            'Total Expenses: ₹ $total',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.amber),
                          );
                        }
                      },
                    )
                  ],
                ),
                FutureBuilder(
                    future: getbalance(trip.id!),
                    builder: (context, snapshot) {
                      final balance = snapshot.data;
                      return Text(
                        'Balance : ₹ $balance',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: screenSize.width * 0.02,
            ),
            const Text(
              'Travel Type',
              style: TextStyle(color: Colors.amber, fontSize: 22),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(0, 18))),
                onPressed: () {},
                child: Text(trip.triptype)),
            SizedBox(
              width: screenSize.width * 0.02,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Transport: ',
                    style: TextStyle(color: Colors.amber, fontSize: 22
                        // Add other style properties as needed
                        ),
                  ),
                  TextSpan(
                    text: trip.transport,
                    style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white, // Color for the database value
                      // Add other style properties as needed
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const Divider(
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        Companiendetails(
          trip: trip,
        ),
      ],
    );
  }
}
