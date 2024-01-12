import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';

class MultipleImageSelector extends StatefulWidget {
  final Function(List<File>) onImagesSelected;

  const MultipleImageSelector({Key? key, required this.onImagesSelected})
      : super(key: key);

  @override
  MultipleImageSelectorState createState() => MultipleImageSelectorState();
}

class MultipleImageSelectorState extends State<MultipleImageSelector> {
  List<XFile> selectedImages = [];

  Future<void> pickMultipleImagesFromGallery() async {
    final pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages.isNotEmpty) {
      setState(() {
        selectedImages.clear();
        selectedImages.addAll(pickedImages);
      });
      widget.onImagesSelected(
          selectedImages.map((image) => File(image.path)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickMultipleImagesFromGallery();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 13),
          selectedImages.isNotEmpty
              ? CarouselSlider.builder(
                  itemCount: selectedImages.length,
                  options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: selectedImages.length > 2,
                      autoPlay: false),
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return Container(
                      width: 370,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: FileImage(File(selectedImages[index].path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  width: 370,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.add_photo_alternate,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }
}
