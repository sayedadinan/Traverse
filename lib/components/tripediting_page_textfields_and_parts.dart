import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/components/trip_widgets/choichips.dart';
import 'package:traverse_1/components/trip_widgets/drop_down.dart';
import 'package:traverse_1/components/trip_widgets/edit_companion.dart';
import 'package:traverse_1/components/trip_widgets/textfields.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/view/screens/home_page.dart';

class Editingpagefields extends StatefulWidget {
  final Tripmodel trip;
  const Editingpagefields({super.key, required this.trip});

  @override
  State<Editingpagefields> createState() => _EditingpagefieldsState();
}

class _EditingpagefieldsState extends State<Editingpagefields> {
  final destinationController = TextEditingController();
  final budgetController = TextEditingController();
  final tripNameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  String triptypeController = 'Other';
  String transport = 'Flight';
  final formKey = GlobalKey<FormState>();
  String? imagePath;
  File? profileimage;
  List<XFile> newlySelectedImages = [];
  @override
  void initState() {
    super.initState();
    tripNameController.text = widget.trip.tripname;
    destinationController.text = widget.trip.destination;
    budgetController.text = widget.trip.budget.toString();
    triptypeController = widget.trip.triptype;
    transport = widget.trip.transport;
    imagePath = widget.trip.coverpic;
    startDateController.text = widget.trip.startingDate;
    endDateController.text = widget.trip.endingDate;
    getExistingCompanions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Inputfield(
            hinttext: 'Enter Trip Name',
            label: 'Trip Name',
            controller: tripNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name for trip';
              }
              final namePattern = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');

              if (!namePattern.hasMatch(value)) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Inputfield(
            hinttext: 'Enter Trip Destination',
            label: 'Destination',
            controller: destinationController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your destination';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Inputfield(
            hinttext: 'How much is that',
            label: 'Trip Budget',
            controller: budgetController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your trip budget';
              }
              final RegExp regex = RegExp(r'^-?\d+(\.\d+)?$');

              if (!regex.hasMatch(value)) {
                return 'Please enter a valid number';
              }
              final double parsedValue = double.parse(value);
              if (parsedValue <= 0) {
                return 'Please enter a positive value';
              }
              return null;
            },
          ),
        ),
        const Text(
          'choose preffered transport',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 37, 62, 207),
          ),
        ),
        MyChoiceChip(
          onChipSelected: (String selectedValue) {
            if (selectedValue.isNotEmpty) {
              setState(() {
                transport = selectedValue;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a valid transport option'),
                ),
              );
            }
            setState(() {
              transport = selectedValue;
            });
          },
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'select travel purpose',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 37, 62, 207),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Dropdownmenu(
            items: const ['Business', 'Entertainment', 'Family', 'Other'],
            initialValue: 'Other',
            // initialValue: triptypeController,
            onChanged: (String newValue) {
              if (newValue.isNotEmpty) {
                setState(() {
                  triptypeController = newValue;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select an option.'),
                  ),
                );
              }
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 160,
                child: TextFormField(
                  controller: startDateController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 244, 241, 241),
                    filled: true,
                    labelText: 'Starting Date',
                    hintText: 'Give date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                width: 160,
                child: TextFormField(
                  controller: endDateController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 244, 241, 241),
                    filled: true,
                    labelText: 'Ending Date',
                    hintText: 'Give date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> getExistingCompanions() async {
    try {
      final List<Map<String, dynamic>> existingCompanions = await getCompanions(
          widget.trip.id!); // Fetch existing companions from the database
      setState(() {
        editcontactlist
            .clear(); // Clear the existing list before adding fetched companions
        editcontactlist
            .addAll(existingCompanions); // Add fetched companions to the list
      });
    } catch (e) {
      log(-1);
    }
  }

  Future<void> editTripClicked(BuildContext context) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      if (triptypeController.isEmpty || transport.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select transport and trip type.'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Prevent form submission if values are not selected
      }

      await editTrip(
          tripNameController.text,
          destinationController.text,
          budgetController.text,
          transport,
          triptypeController,
          imagePath,
          startDateController.text,
          endDateController.text,
          widget.trip.id,
          widget.trip.userid,
          newlySelectedImages,
          editcontactlist);
      await getalltrip(widget.trip.userid!);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Homescreen(
            profileid: widget.trip.userid!,
          ),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
