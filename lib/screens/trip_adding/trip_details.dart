import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/custom_widgets/trip_add/companiens.dart';
import 'package:traverse_1/screens/home_page.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import '../../data/functions/tripdata.dart';
import '../../data/models/trip/trip_model.dart';
import '../../custom_widgets/elevatedbuttons.dart';
import '../../custom_widgets/trip_add/choichips.dart';
import '../../custom_widgets/trip_add/drop_down.dart';
import '../../custom_widgets/trip_add/textfields.dart';

class Addtripdetail extends StatefulWidget {
  final int profileid;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  const Addtripdetail({
    Key? key,
    required this.startDateController,
    required this.endDateController,
    required this.profileid,
  }) : super(key: key);

  @override
  State<Addtripdetail> createState() => _AddtripdetailState();
}

class _AddtripdetailState extends State<Addtripdetail> {
  final destinationController = TextEditingController();
  final budgetController = TextEditingController();
  final tripNameController = TextEditingController();
  String triptypeController = 'Other';
  String transport = 'Flight';
  final formKey = GlobalKey<FormState>();
  String? imagePath;
  File? profileimage;
  final List<String> imageList = [
    'assets/car traverse.png',
    'assets/applounch.png',
  ];

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

                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(20),
                          //   child: CarouselSlider(
                          //     options: CarouselOptions(
                          //       aspectRatio: 1.0,
                          //       enlargeCenterPage: true,
                          //       autoPlay: true,
                          //     ),
                          //     items: imageList.map((imagePath) {
                          //       return Image.asset(
                          //         imagePath,
                          //         fit: BoxFit.cover,
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
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
                      initialValue: triptypeController,
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
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      filled: true,
                      labelText: 'Add companions',
                      hintText: 'Enter companion name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MyCompanion(
                          context: context,
                          functionCheck: true,
                          text: '  Select companions',
                        ),
                      ),
                      Expanded(
                        child: MyCompanion(
                          text: '  Show companions',
                          context: context,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Elebuttons(
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        await addtrip();

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                Homescreen(profileid: widget.profileid),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    text: 'Finish',
                    butcolor: const Color.fromARGB(255, 119, 200, 192),
                    textcolor: Colors.orange,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      profileimage = File(returnedImage.path);
      imagePath = returnedImage.path.toString();
    });
  }

  Future<void> addtrip() async {
    try {
      var trip = Tripmodel(
          tripname: tripNameController.text,
          destination: destinationController.text,
          budget: double.parse(budgetController.text),
          triptype: triptypeController,
          transport: transport,
          startingDate: widget.startDateController.text,
          endingDate: widget.endDateController.text,
          coverpic: imagePath,
          userid: widget.profileid);

      int tripId = await tripadding(trip);
      if (tripId != -1) {
        trip.id = tripId;
        print('Trip added successfully with ID: $tripId');
      } else {
        print('Failed to add trip');
      }
    } catch (e) {
      print('Error adding trip: $e');
    }
  }
}
