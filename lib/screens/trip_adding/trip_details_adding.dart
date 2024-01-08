import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/custom_widgets/trip_widgets/companiens_add.dart';
import 'package:traverse_1/custom_widgets/trip_widgets/multiple_image_add.dart';
import 'package:traverse_1/screens/home_page.dart';
import '../../data/functions/tripdata.dart';
import '../../data/models/trip/trip_model.dart';
import '../../custom_widgets/elevatedbuttons.dart';
import '../../custom_widgets/trip_widgets/choichips.dart';
import '../../custom_widgets/trip_widgets/drop_down.dart';
import '../../custom_widgets/trip_widgets/textfields.dart';

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
  List<File> selectedImages = [];
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
                  MultipleImageSelector(
                    onImagesSelected: (images) {
                      setState(() {
                        selectedImages = images;
                      });
                    },
                  ),
                  const SizedBox(height: 13),
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
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
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
                  const SizedBox(
                    height: 25,
                  ),
                  Elebuttons(
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        await addtrip();

                        // ignore: use_build_context_synchronously
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
                  const SizedBox(
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

      int tripId = await tripAdding(
        trip,
        companionList,
        selectedImages,
      );
      // print(companionList);
      if (tripId != -1) {
        trip.id = tripId;
      } else {}
    } catch (e) {
      log(-1);
    }
  }
}
