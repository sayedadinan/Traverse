import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/custom_widgets/trip_add/details_tab.dart';
import 'package:traverse_1/custom_widgets/trip_add/expense_detail.dart';
import 'package:traverse_1/custom_widgets/trip_add/media_widget.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/trip_editing.dart';
import '../../data/functions/tripdata.dart';

class Tripdetails1 extends StatefulWidget {
  const Tripdetails1({
    Key? key,
    required this.trip,
  }) : super(key: key);

  final Tripmodel trip;

  @override
  State<Tripdetails1> createState() => _Tripdetails1State();
}

class _Tripdetails1State extends State<Tripdetails1>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String? imagePath;
  File? profileimage;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    getExpenses(widget.trip.id!);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 28, 28),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.trip.tripname,
          style: const TextStyle(color: Colors.amber, fontSize: 30),
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
            icon: const Icon(Icons.edit),
          ),
          IconButton(
              onPressed: () {
                showDeleteConfirmationDialog(context, () {
                  deletetrip(widget.trip.id, widget.trip.userid);
                  Navigator.of(context).pop();
                });
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 370,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: widget.trip.coverpic != null &&
                              File(widget.trip.coverpic!).existsSync()
                          ? FileImage(File(widget.trip.coverpic!))
                              as ImageProvider<Object>
                          : const AssetImage(
                              'assets/placeholder for traverse.jpg',
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.trip.destination,
                    style: TextStyle(fontSize: 28, color: Colors.green[100]),
                  ),
                  Text(
                    widget.trip.startingDate,
                    style: TextStyle(fontSize: 28, color: Colors.green[100]),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.green,
                  labelStyle: const TextStyle(fontSize: 25),
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Media'),
                    Tab(text: 'Details'),
                    Tab(text: 'Expenses'),
                  ],
                ),
              ),
            ),
            Container(
              height: 700, // Adjust height as needed
              child: TabBarView(
                controller: tabController,
                children: [
                  Mymedia(
                    trip: widget.trip,
                  ),
                  Detailstab(
                    trip: widget.trip,
                  ),
                  Expensedetails(
                    trip: widget.trip,
                  )
                ],
              ),
            ),
          ],
        ),
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
