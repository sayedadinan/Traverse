import 'dart:math';
import 'package:flutter/material.dart';
import 'package:traverse_1/custom_widgets/elevatedbuttons.dart';
import 'package:traverse_1/custom_widgets/trip_widgets/textfields.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/feedback_model.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/trip_details_page.dart';
import 'package:intl/intl.dart';

class Feedbackpage extends StatefulWidget {
  final Tripmodel trip;
  const Feedbackpage({super.key, required this.trip});

  @override
  State<Feedbackpage> createState() => _FeedbackpageState();
}

class _FeedbackpageState extends State<Feedbackpage> {
  final feedbackcontroller = TextEditingController();
  final dateController = TextEditingController(
    text: DateFormat('dd-MMM-yyyy').format(DateTime.now()),
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[200],
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.06,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: Inputfield(
                  label: 'Todays date',
                  hinttext: 'say about today',
                  controller: dateController,
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
                  label: 'Add feedback',
                  hinttext: 'say your experience',
                  controller: feedbackcontroller,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
              ),
              Elebuttons(
                text: 'Finish',
                butcolor: const Color.fromARGB(255, 119, 200, 192),
                textcolor: Colors.orange,
                function: () async {
                  if (_formKey.currentState!.validate()) {
                    await addingfeedback();
                    // await getExpenses(widget.trip.id!);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Tripdetails(trip: widget.trip),
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

  Future<void> addingfeedback() async {
    print(dateController);
    try {
      var feedback = FeedbackModel(
          feedbackdate: dateController.text,
          id: widget.trip.id,
          tripID: widget.trip.id,
          feedback: feedbackcontroller.text);
      final feedbackId = await feedbckadding(feedback, widget.trip.id!);
      feedback.id = feedbackId;
      // getExpenses(widget.trip.id!);
    } catch (e) {
      log(-1);
    }
  }
}
