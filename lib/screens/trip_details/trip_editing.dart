import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/home_page.dart';
import 'package:traverse_1/screens/trip_details/all_details.dart';
import '../../custom_widgets/elevatedbuttons.dart';
import '../../custom_widgets/trip_add/choichips.dart';
import '../../custom_widgets/trip_add/companiens.dart';
import '../../custom_widgets/trip_add/drop_down.dart';
import '../../custom_widgets/trip_add/textfields.dart';
import '../../data/functions/tripdata.dart';

class Editingtrip extends StatefulWidget {
  final int? profileid;
  final Tripmodel trip;
  const Editingtrip({
    super.key,
    required this.profileid,
    required this.trip,
  });

  @override
  State<Editingtrip> createState() => _EditingtripState();
}

class _EditingtripState extends State<Editingtrip> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Tour'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        pickImageFromGallery();
                      },
                      child: Container(
                        width: 370,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imagePath != null &&
                                    File(imagePath!).existsSync()
                                ? FileImage(File(imagePath!))
                                    as ImageProvider<Object>
                                : const AssetImage(
                                    'assets/placeholder for traverse.jpg',
                                  ),
                            fit: BoxFit.cover,
                            // image: imagePath != null && File(imagePath).existsSync()
                            //     ? FileImage(File(imagePath))
                            //         as ImageProvider<Object>?
                            //     : const AssetImage(
                            //         'assets/user.png',
                            //       ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 13),
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
                        final namePattern =
                            RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');

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
                            content:
                                Text('Please select a valid transport option'),
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
                      items: const [
                        'Business',
                        'Entertainment',
                        'Family',
                        'Other'
                      ],
                      initialValue: 'Business',
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
                        child: Container(
                          width: 160,
                          child: TextFormField(
                            controller: startDateController,
                            decoration: InputDecoration(
                              fillColor:
                                  const Color.fromARGB(255, 244, 241, 241),
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
                        child: Container(
                          width: 160,
                          child: TextFormField(
                            controller: endDateController,
                            decoration: InputDecoration(
                              fillColor:
                                  const Color.fromARGB(255, 244, 241, 241),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MyCompanion(
                            context: context,
                            functionCheck: true,
                            text: '  Select companions',
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: MyCompanion(
                            text: '  Show companions',
                            context: context,
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 15,
                  ),
                  Elebuttons(
                    function: () async {
                      editTripClicked(context);
                    },
                    text: 'Update',
                    butcolor: const Color.fromARGB(255, 119, 200, 192),
                    textcolor: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      setState(() {
        profileimage = File(pickedImage.path);
        imagePath = pickedImage.path;
      });
    } catch (e) {
      ('Error picking image: $e');
    }
  }

  Future<void> editTripClicked(BuildContext context) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      await editTrip(
        tripNameController.text.toLowerCase(),
        destinationController.text.toLowerCase(),
        budgetController.text,
        triptypeController,
        transport,
        imagePath,
        startDateController.text.toLowerCase(),
        endDateController.text.toLowerCase(),
        widget.trip.id,
      );
      print('id number ${widget.trip.id}');
      print(widget.trip.userid);
      // Refresh the data after editing the trip details
      // (Assuming refreshTripData is a function to refresh trip data)
      await getalltrip(widget.trip.userid!);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Homescreen(
            profileid: widget.trip.userid!,
          ),
        ),
        (route) =>
            false, // Replace 'false' with the condition to stop removing routes
      );
      // Navigator.of(context).pop();
    } else {
      // Show an error message if there are validation errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
