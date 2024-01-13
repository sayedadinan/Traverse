import 'dart:io';
import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/feedback_add.dart';
import 'package:traverse_1/screens/trip_details/trip_details_page.dart';

class Feedbackdetails extends StatefulWidget {
  const Feedbackdetails({Key? key, required this.trip}) : super(key: key);
  final Tripmodel trip;

  @override
  State<Feedbackdetails> createState() => _FeedbackdetailsState();
}

class _FeedbackdetailsState extends State<Feedbackdetails> {
  final sponsorController = TextEditingController();
  final reasonController = TextEditingController();
  final moneyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getfeedback(widget.trip.id!);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 28, 28),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: screenSize.width * 02,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Feedbackpage(
                      trip: widget.trip,
                    ),
                  ));
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Feedback'),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getfeedback(widget.trip.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final data = snapshot.data;
                  if (data == null || data.isEmpty) {
                    return const Center(
                      child: Text(
                        'You Have no Feedbacks',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            elevation: 20,
                            color: const Color.fromARGB(255, 59, 58, 54),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: data[index]['imagepath'] !=
                                        null
                                    ? FileImage(File(data[index]['imagepath']))
                                        as ImageProvider
                                    : const AssetImage('assets/traverse 8.jpg'),
                              ),
                              title: Text(
                                '${data[index]['feedback']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 19,
                                ),
                              ),
                              trailing: Text(
                                data[index]['feedbackdate'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              // onTap: () {
                              //   Navigator.of(context).push(MaterialPageRoute(
                              //       builder: (context) => Feedbackshowing()));
                              // },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Delete Expense"),
                                      content: const Text(
                                          "Are you sure you want to delete this expense?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            deletefeedback(data[index]['id']);
                                            Navigator.pushReplacement(
                                              context,
                                              (MaterialPageRoute(
                                                builder: (context) =>
                                                    Tripdetails(
                                                  trip: widget.trip,
                                                ),
                                              )),
                                            );
                                          },
                                          child: const Text("Delete"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
