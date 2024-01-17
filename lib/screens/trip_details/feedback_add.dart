import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? selectedImage;
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.06,
                ),
                GestureDetector(
                    onTap: () {
                      pickImageFromGallery();
                    },
                    child: Stack(children: [
                      Container(
                          height: screenSize.height * 0.4,
                          width: screenSize.width * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: selectedImage != null
                                  ? DecorationImage(
                                      image: FileImage(selectedImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image:
                                          AssetImage('assets/traverse 8.jpg'),
                                      fit: BoxFit.cover,
                                    ))),
                      Positioned(
                          bottom: 16, // Adjust the position as needed
                          right: 16, // Adjust the position as needed
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 35,
                            ),
                            onPressed: () {},
                          ))
                    ])),
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
                    )),
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
                    )),
                Elebuttons(
                    text: 'Save',
                    butcolor: const Color.fromARGB(255, 119, 200, 192),
                    textcolor: Colors.orange,
                    function: () async {
                      if (_formKey.currentState!.validate()) {
                        await addingfeedback();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                Tripdetails(trip: widget.trip),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addingfeedback() async {
    try {
      var feedback = FeedbackModel(
          // ignore: prefer_null_aware_operators
          imagepath: selectedImage != null ? selectedImage!.path : null,
          feedbackdate: dateController.text,
          id: widget.trip.id,
          tripID: widget.trip.id,
          feedback: feedbackcontroller.text);
      final feedbackId = await feedbckadding(feedback, widget.trip.id!);
      feedback.id = feedbackId;
    } catch (e) {
      log(-1);
    }
  }

  Future pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    final file = File(pickedImage.path);
    setState(() {
      selectedImage = file;
    });
  }
}
