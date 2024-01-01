// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:traverse_1/data/functions/properties_trip.dart';
// import 'package:traverse_1/data/models/trip/media_model.dart';
// import 'package:traverse_1/data/models/trip/trip_model.dart';

// class Photoadd extends StatefulWidget {
//   final Tripmodel trip;
//   Photoadd({Key? key, required this.trip}) : super(key: key);

//   @override
//   State<Photoadd> createState() => _PhotoaddState();
// }

// class _PhotoaddState extends State<Photoadd> {
//   List<File> selectedImages = []; // List to store selected images
//   @override
//   void initState() {
//     super.initState();
//     fetchMediaFromDB();
//   }

//   Future<void> fetchMediaFromDB() async {
//     List<Map<String, dynamic>>? mediaList = await getmediapics(widget.trip.id!);

//     if (mediaList != null && mediaList.isNotEmpty) {
//       setState(() {
//         for (var media in mediaList) {
//           selectedImages.add(File(media['mediaPic']));
//           print(selectedImages);
//           print(mediaList);
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 30, 28, 28),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 pickImageFromGallery();
//               },
//               child: const Text('Add Image'),
//             ),
//             const SizedBox(height: 20.0),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                 ),
//                 itemCount: selectedImages.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Stack(
//                     children: [
//                       Image.file(
//                         selectedImages[index],
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         height: double.infinity,
//                       ),
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: IconButton(
//                           icon: Icon(Icons.close),
//                           onPressed: () {
//                             setState(() {
//                               selectedImages.removeAt(index);
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future pickImageFromGallery() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage == null) return;
//     final file = File(pickedImage.path);
//     await addMediapics(MediaModel(
//         userId: widget.trip.userid!,
//         tripId: widget.trip.id!,
//         mediaImage: file.path));
//     setState(() {
//       selectedImages.add(File(pickedImage.path));
//     });
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/media_model.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class Photoadd extends StatefulWidget {
  final Tripmodel trip;

  const Photoadd({Key? key, required this.trip}) : super(key: key);

  @override
  State<Photoadd> createState() => _PhotoaddState();
}

class _PhotoaddState extends State<Photoadd> {
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
            GestureDetector(
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
                    image: selectedImages.isNotEmpty
                        ? FileImage(selectedImages.first)
                            as ImageProvider<Object>
                        : const AssetImage(
                            'assets/placeholder for traverse.jpg',
                          ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: selectedImages.isEmpty
                  ? const Center(
                      child: Text(
                        'No images selected',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : CarouselSlider.builder(
                      itemCount: selectedImages.length,
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.8,
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Image.file(
                          selectedImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
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
