import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class Add2 extends StatelessWidget {
  final List<String> imageList = [
    'assets/car traverse.png',
    'assets/applounch.png',
    // 'assets/image3.jpg',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add tour'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 370,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                    items: imageList.map((imagePath) {
                      return Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // controller: _userController,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 244, 241, 241),
                  filled: true,
                  labelText: 'Trip name',
                  hintText: 'gave the name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // controller: _userController,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 244, 241, 241),
                  filled: true,
                  labelText: 'Destination',
                  hintText: 'where is that? ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // controller: _userController,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 244, 241, 241),
                  filled: true,
                  labelText: 'Trip budget',
                  hintText: 'How much is that?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const Text(
              'choose preffered transport',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 37, 62, 207)),
            )
          ],
        ),
      ),
    );
  }
}
