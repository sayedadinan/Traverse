import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class EditCoverimage extends StatefulWidget {
  final Function(List<XFile>) onImagesSelected;
  const EditCoverimage(
      {super.key, required this.trip, required this.onImagesSelected});
  final Tripmodel trip;
  @override
  State<EditCoverimage> createState() => _EditCoverimageState();
}

class _EditCoverimageState extends State<EditCoverimage> {
  List<XFile> selectedImages = [];
  List<XFile> newlySelectedImages = [];
  Future<void> getExistingphoto() async {
    try {
      final List<String> existingPhotoPaths =
          await getCoverImages(widget.trip.id!);

      setState(() {
        selectedImages.clear();
        selectedImages
            .addAll(existingPhotoPaths.map((path) => XFile(path)).toList());
      });
    } catch (e) {
      log(-1);
    }
  }

  Future<void> pickMultipleImagesFromGallery() async {
    final pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages.isNotEmpty && pickedImages.isNotEmpty) {
      setState(() {
        selectedImages.clear(); // Clear existing images
        selectedImages.addAll(pickedImages);
      });
      List<XFile> newlySelectedImages = [];
      for (var image in selectedImages) {
        newlySelectedImages.add(XFile(image.path));
      }
      widget.onImagesSelected(newlySelectedImages);
    }
  }

  Future<void> updateSelectedImagesList(List<File> newlySelectedImages) async {
    // Check if there are already some selected images
    if (selectedImages.isNotEmpty) {
      // Add newly selected images to the existing list if not already present
      for (var image in newlySelectedImages) {
        // ignore: iterable_contains_unrelated_type
        if (!selectedImages.contains(image)) {
          selectedImages.add(image as XFile);
        }
      }
    } else {
      // If no images were previously selected, directly assign the newly selected images
      selectedImages.addAll(newlySelectedImages as Iterable<XFile>);
    }
    // Notify the widget tree about the changes in selected images
    setState(() {});
  }

  @override
  void initState() {
    getExistingphoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
          itemCount: selectedImages.isNotEmpty ? selectedImages.length : 1,
          itemBuilder: (context, index, realIndex) {
            if (selectedImages.isEmpty) {
              // Show placeholder image or any default content when no images are available
              return GestureDetector(
                onTap: () {
                  pickMultipleImagesFromGallery();
                },
                child: Container(
                  width: 370,
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/traverse 8.jpg')),
                    borderRadius: BorderRadius.circular(20),
                    // color: const Color.fromARGB(
                    //     255, 218, 174, 41), // Placeholder color
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              File imageFile = File(selectedImages[index].path);
              return GestureDetector(
                onTap: () {
                  pickMultipleImagesFromGallery();
                },
                child: Container(
                  width: 370,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: FileImage(imageFile),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
