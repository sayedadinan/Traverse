import 'package:flutter/material.dart';
import 'package:traverse_1/custom_widgets/elevatedbuttons.dart';
import 'package:traverse_1/custom_widgets/trip_add/textfields.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/expenses_model.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/trip_details_page.dart';

class Expenses extends StatelessWidget {
  final Tripmodel trip;
  Expenses({super.key, required this.trip});
  final sponsorController = TextEditingController();
  final reasonController = TextEditingController();
  final moneyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: const Text('Add your expenses'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            // Text('Add your all expenses this help for your budget maintains  '),
            Padding(
              padding: const EdgeInsets.only(bottom: 23),
              child: Inputfield(
                label: 'Sponsor',
                hinttext: 'who is that?',
                controller: sponsorController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 23),
              child: Inputfield(
                label: 'Spending Purpose',
                hinttext: 'what is the usage ?',
                controller: reasonController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 23),
              child: Inputfield(
                label: 'Money',
                hinttext: 'How much ?',
                controller: moneyController,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Elebuttons(
                text: 'Finish',
                butcolor: const Color.fromARGB(255, 119, 200, 192),
                textcolor: Colors.orange,
                function: () async {
                  await addingExpense();
                  getExpenses(trip.id!);
                  Navigator.of(context).pop();
                }
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => Tripdetails1(
                //       trip: trip,
                //     ),
                //   ),
                // );
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => Tripdetails1(
                //           trip: trip,
                )
          ],
        ),
      ),
    );
  }

  Future<void> addingExpense() async {
    try {
      var expense = ExpenseModel(
        reason: reasonController.text,
        sponsor: sponsorController.text,
        amount: int.parse(moneyController.text),
        tripID: trip.id!,
        userId: trip.userid!,
      );
      final expenseId = await addExpense(expense);
      expense.id = expenseId;
      getExpenses(trip.id!);
      print('Added expense with ID: ${expense.id}');
      print('Added from local');
    } catch (e) {
      print('Not added because of error: $e');
    }
  }
}
