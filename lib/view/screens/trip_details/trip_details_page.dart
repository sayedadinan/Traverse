import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/components/trip_detals_widget.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/view/screens/trip_details/trip_editing.dart';
import '../../../data/functions/tripdata.dart';

class Tripdetails extends StatefulWidget {
  const Tripdetails({
    Key? key,
    required this.trip,
  }) : super(key: key);

  final Tripmodel trip;

  @override
  State<Tripdetails> createState() => _TripdetailsState();
}

class _TripdetailsState extends State<Tripdetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String? imagePath;
  File? profileimage;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    getExpenses(widget.trip.id!);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 28, 28),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.trip.tripname.toUpperCase(),
          style: const TextStyle(color: Colors.amber, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Editingtrip(
                        profileid: widget.trip.id,
                        trip: widget.trip,
                      )));
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.amber,
            ),
          ),
          IconButton(
              onPressed: () {
                showDeleteConfirmationDialog(context, () {
                  deletetrip(widget.trip.id, widget.trip.userid);
                  Navigator.of(context).pop();
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.amber,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: tripdetails_showing(
            screenSize: screenSize,
            widget: widget,
            tabController: tabController),
      ),
    );
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

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, Function deleteFunction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deletetrip(widget.trip.id, widget.trip.userid);
                deleteFunction(); // Call the delete function passed as an argument
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
