import 'package:flutter/material.dart';
import 'package:traverse_1/custom_widgets/elevatedbuttons.dart';
import 'package:traverse_1/custom_widgets/trip_widgets/textfields.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/expenses_model.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/trip_details_page.dart';

class Expenses extends StatefulWidget {
  final Tripmodel trip;
  const Expenses({Key? key, required this.trip}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final sponsorController = TextEditingController();
  final reasonController = TextEditingController();
  final moneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Step 1: Create a GlobalKey

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        title: const Text('Add your expenses'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          // Step 2: Wrap your form with a Form widget
          key: _formKey, // Step 3: Attach the GlobalKey to the Form
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: Inputfield(
                  label: 'Sponsor',
                  hinttext: 'who is that?',
                  controller: sponsorController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: Inputfield(
                  label: 'Spending Purpose',
                  hinttext: 'what is the usage ?',
                  controller: reasonController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: Inputfield(
                  label: 'Money',
                  hinttext: 'How much ?',
                  controller: moneyController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    } else {
                      try {
                        final double amount = double.parse(value);
                        if (amount <= 0) {
                          return 'Please enter a positive value';
                        }
                        return null;
                      } catch (e) {
                        return 'Please enter a valid number';
                      }
                    }
                  },
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
                  if (_formKey.currentState!.validate()) {
                    await addingExpense();
                    await getExpenses(widget.trip.id!);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Tripdetails1(trip: widget.trip),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ],
          ),
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
        tripID: widget.trip.id!,
        userId: widget.trip.userid!,
      );
      final expenseId = await addExpense(expense);
      expense.id = expenseId;
      getExpenses(widget.trip.id!);
      print('Added expense with ID: ${expense.id}');
      print('Added from local');
    } catch (e) {
      print('Not added because of error: $e');
    }
  }
}
