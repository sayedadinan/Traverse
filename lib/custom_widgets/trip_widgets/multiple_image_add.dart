import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';

class MultipleImageSelector extends StatefulWidget {
  final Function(List<File>) onImagesSelected;

  const MultipleImageSelector({Key? key, required this.onImagesSelected})
      : super(key: key);

  @override
  _MultipleImageSelectorState createState() => _MultipleImageSelectorState();
}

class _MultipleImageSelectorState extends State<MultipleImageSelector> {
  List<XFile> selectedImages = [];

  Future<void> pickMultipleImagesFromGallery() async {
    final pickedImages = await ImagePicker().pickMultiImage(
        // Adjust parameters according to your requirements
        // maxWidth: 1000,
        // maxHeight: 1000,
        );

    if (pickedImages.isNotEmpty && pickedImages.isNotEmpty) {
      setState(() {
        selectedImages.clear(); // Clear existing images
        selectedImages.addAll(pickedImages);
      });
      widget.onImagesSelected(
          selectedImages.map((image) => File(image.path)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            pickMultipleImagesFromGallery();
          },
          child: Visibility(
            visible: selectedImages.isEmpty,
            child: Container(
              width: 370,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                // Display placeholder image or first selected image
                image: DecorationImage(
                  image: selectedImages.isNotEmpty
                      ? FileImage(File(selectedImages.first.path))
                          as ImageProvider<Object>
                      : const AssetImage(
                          'assets/placeholder for traverse.jpg',
                        ),
                  fit: BoxFit
                      .fitWidth, // Set fitWidth to contain image within the container width
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 13),
        selectedImages.isNotEmpty
            ? CarouselSlider.builder(
                itemCount: selectedImages.length,
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  // viewportFraction: 0.8,
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Image.file(
                    File(selectedImages[index].path),
                    fit: BoxFit.cover,
                  );
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
