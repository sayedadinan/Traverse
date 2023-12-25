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
    fetchMediaFromDB(); // Fetch media from the database when the widget initializes
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
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                pickImageFromGallery();
              },
              child: Text('Add Image'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:traverse_1/data/functions/properties_trip.dart';
// import 'package:traverse_1/data/models/trip/media_model.dart';
// import 'package:traverse_1/data/models/trip/trip_model.dart';

// class Mymedia extends StatefulWidget {
//   final Tripmodel trip;
//   Mymedia({Key? key, required this.trip}) : super(key: key);

//   @override
//   State<Mymedia> createState() => _MymediaState();
// }

// class _MymediaState extends State<Mymedia> {
//   List<String> selectedImagePaths = []; // List to store selected image paths

//   @override
//   void initState() {
//     super.initState();
//     fetchMediaFromDB();
//   }

//   Future<void> fetchMediaFromDB() async {
//     await retrieveImagesFromDB();
//   }

//   Future<void> retrieveImagesFromDB() async {
//     List<Map<String, dynamic>>? mediaList = await getmediapics(widget.trip.id!);

//     if (mediaList != null && mediaList.isNotEmpty) {
//       setState(() {
//         selectedImagePaths =
//             mediaList.map((media) => media['mediaPic'] as String).toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 pickMultipleImagesFromGallery();
//               },
//               child: Text('Add Images'),
//             ),
//             const SizedBox(height: 20.0),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                 ),
//                 itemCount: selectedImagePaths.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return buildImageTile(index);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildImageTile(int index) {
//     return Stack(
//       children: [
//         Image.file(
//           File(selectedImagePaths[index]),
//           fit: BoxFit.cover,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         Positioned(
//           top: 0,
//           right: 0,
//           child: IconButton(
//             icon: Icon(Icons.close),
//             onPressed: () {
//               removeImageAtIndex(index);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> pickMultipleImagesFromGallery() async {
//     List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
//     if (pickedImages == null || pickedImages.isEmpty) return;

//     for (XFile image in pickedImages) {
//       final imagePath = image.path;
//       await addMediapics(MediaModel(
//         userId: widget.trip.userid!,
//         tripId: widget.trip.id!,
//         mediaImage: imagePath,
//       ));
//     }

//     await retrieveImagesFromDB(); // Refresh images after adding new ones
//   }

//   void removeImageAtIndex(int index) async {
//     setState(() {
//       selectedImagePaths.removeAt(index);
//     });

//     // TODO: Implement logic to delete the image from the database
//     // await deleteImageFromDB(selectedImagePaths[index]);
//   }
// }
