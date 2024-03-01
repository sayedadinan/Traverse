import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/media_model.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class Mymedia extends StatefulWidget {
  final Tripmodel trip;
  const Mymedia({Key? key, required this.trip}) : super(key: key);

  @override
  State<Mymedia> createState() => _MymediaState();
}

class _MymediaState extends State<Mymedia> {
  List<File> selectedImages = [];
  List<int> mediaIds = [];

  @override
  void initState() {
    super.initState();
    fetchMediaFromDB();
  }

  Future<void> fetchMediaFromDB() async {
    List<Map<String, dynamic>>? mediaList = await getmediapics(widget.trip.id!);

    if (mediaList != null && mediaList.isNotEmpty) {
      setState(() {
        for (var media in mediaList) {
          File file = File(media['mediaPic']);
          selectedImages.add(file);
          mediaIds.add(media['id']); // Store corresponding media id
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 28, 28),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(0, 40)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Add Image'),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            selectedImages.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text(
                        'No images selected',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: selectedImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Image.file(
                              selectedImages[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    showDeleteConfirmationDialog(context, () {
                                      int mediaId = mediaIds[index];
                                      deletemedia(mediaId);
                                      Navigator.of(context).pop();
                                    }, index);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    final file = File(pickedImage.path);

    // Add the new media entry to the database
    await addMediapics(MediaModel(
        userId: widget.trip.userid!,
        tripId: widget.trip.id!,
        mediaImage: file.path));

    // Retrieve the newly added media entry from the database
    Map<String, dynamic> newMedia = (await getmediapics(widget.trip.id!))!.last;

    // Update the lists with the new media entry
    setState(() {
      selectedImages.add(file);
      mediaIds.add(newMedia['id']);
    });
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, Function deleteFunction, int index) async {
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
                deleteFunction();
                int mediaId = mediaIds[index];
                deletemedia(mediaId);
                // Call the delete function passed as an argument
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
