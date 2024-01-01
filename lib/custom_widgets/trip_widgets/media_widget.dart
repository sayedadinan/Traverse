import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/media_model.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class Mymedia extends StatefulWidget {
  final Tripmodel trip;
  Mymedia({Key? key, required this.trip}) : super(key: key);

  @override
  State<Mymedia> createState() => _MymediaState();
}

class _MymediaState extends State<Mymedia> {
  List<File> selectedImages = []; // List to store selected images
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
          selectedImages.add(File(media['mediaPic']));
          print(selectedImages);
          print(mediaList);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  minimumSize: MaterialStateProperty.all(Size(0, 40))),
              child: const Text('Add Image'),
            ),
            const SizedBox(height: 20.0),
            selectedImages.isEmpty // Check if selectedImages list is empty
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
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    selectedImages.removeAt(index);
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
    await addMediapics(MediaModel(
        userId: widget.trip.userid!,
        tripId: widget.trip.id!,
        mediaImage: file.path));
    setState(() {
      selectedImages.add(File(pickedImage.path));
    });
  }
}
