import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/add_expenses.dart';

class Expensedetails extends StatefulWidget {
  const Expensedetails({super.key, required this.trip});
  final Tripmodel trip;

  @override
  State<Expensedetails> createState() => _ExpensedetailsState();
}

class _ExpensedetailsState extends State<Expensedetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExpenses(widget.trip.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 28, 28),
      body: FutureBuilder(
        future: getExpenses(widget.trip.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data as List<dynamic>?; // Use nullable type
            if (data == null || data.isEmpty) {
              return Center(
                  child: Text(
                'You Have no Expenses',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ));
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListTile(
                      title: Text(
                        '${data[index]['amount']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                      subtitle: Text(
                        'amount paid by ${data[index]['reason']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        '₹ ${data[index]['sponsor']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 130),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Expenses(trip: widget.trip),
            ));
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Expense'),
        ),
      ),
    );
  }
}
