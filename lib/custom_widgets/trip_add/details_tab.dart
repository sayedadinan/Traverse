import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class Detailstab extends StatelessWidget {
  const Detailstab({super.key, required this.trip});
  final Tripmodel trip;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Starting date',
              style: TextStyle(fontSize: 28, color: Colors.amber),
            ),
            SizedBox(
              width: 39,
            ),
            Text(
              'Ending date',
              style: TextStyle(fontSize: 28, color: Colors.amber),
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
                style: const TextStyle(fontSize: 24, color: Colors.amber),
              ),
              const SizedBox(
                width: 39,
              ),
              Text(
                trip.endingDate,
                style: const TextStyle(fontSize: 24, color: Colors.amber),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 39),
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.amber),
                borderRadius: BorderRadius.circular(19)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'Trip ',
                  style: TextStyle(color: Colors.amber, fontSize: 24),
                ),
                const Text(
                  'Budget',
                  style: TextStyle(color: Colors.amber, fontSize: 24),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  '₹' + trip.budget.toString(),
                  style: const TextStyle(fontSize: 22, color: Colors.amber),
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
                            'Total Expenses: $total',
                            style: const TextStyle(
                                fontSize: 17, color: Colors.amber),
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
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      );
                    }),
              ],
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            const Text(
              'Travel Type',
              style: TextStyle(color: Colors.amber, fontSize: 29),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(0, 18))),
                onPressed: () {},
                child: Text(trip.triptype))
            // Text(
            //   widget.trip.triptype,
            //   style:
            //       TextStyle(color: Colors.amber, fontSize: 25),
            // )
          ],
        ),
        const Divider(
          thickness: 3,
          indent: 25,
          endIndent: 25,
        )
      ],
    );
  }
}
