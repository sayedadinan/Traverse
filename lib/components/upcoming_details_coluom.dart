import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/view/screens/trip_details/upcoming_trip_details.dart';

class upcoming_main_coloum extends StatelessWidget {
  const upcoming_main_coloum({
    super.key,
    required this.widget,
    required this.screenSize,
  });

  final Upcomingdetails widget;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        FutureBuilder<List<String>>(
          future: getCoverImages(widget.trip.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading images: ${snapshot.error}',
                  style: const TextStyle(color: Colors.amber),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                width: screenSize.width * 0.4,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/placeholder for traverse.jpg'))),
              );
            } else {
              return CarouselSlider(
                options: CarouselOptions(
                  height:
                      screenSize.height * 0.2, // Adjust the height as needed
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                ),
                items: snapshot.data!.map((imagePath) {
                  File imageFile = File(imagePath);
                  if (!imageFile.existsSync()) {
                    throw Exception("File does not exist");
                  }
                  return Container(
                    width: screenSize.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: FileImage(imageFile),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
        SizedBox(
          height: screenSize.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'To :  ${widget.trip.destination.toUpperCase()}',
                style: const TextStyle(
                    fontSize: 28,
                    // fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 211, 165, 228)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Starting date',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(width: 39),
              Text(
                'Ending date',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 27),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.trip.startingDate,
                style: const TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 211, 165, 228)),
              ),
              const SizedBox(width: 39),
              Text(
                widget.trip.endingDate,
                style: const TextStyle(
                    fontSize: 24, color: Color.fromARGB(255, 211, 165, 228)),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 3,
          indent: 20,
          endIndent: 20,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 39),
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 209, 137, 235)),
              borderRadius: BorderRadius.circular(19),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Trip ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 209, 137, 235), fontSize: 24),
                ),
                const Text(
                  'Budget',
                  style: TextStyle(
                      color: Color.fromARGB(255, 209, 137, 235), fontSize: 24),
                ),
                const SizedBox(height: 1),
                Text(
                  '₹  ${widget.trip.budget.toString()}',
                  style: const TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 209, 137, 235)),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 20),
            const Text(
              'Travel Type',
              style: TextStyle(
                  color: Color.fromARGB(255, 209, 137, 235), fontSize: 18),
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(0, 18)),
              ),
              onPressed: () {},
              child: Text(widget.trip.triptype),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Transport: ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 209, 137, 235), fontSize: 18
                        // Add other style properties as needed
                        ),
                  ),
                  TextSpan(
                    text: widget.trip.transport,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const Divider(
          thickness: 3,
          indent: 25,
          endIndent: 25,
        ),
        const Row(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              'Companions',
              style: TextStyle(
                  color: Color.fromARGB(255, 209, 137, 235), fontSize: 28),
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: getCompanions(widget.trip.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(left: 120, top: 20),
                  child: Text(
                    'Solo trip',
                    style: TextStyle(
                        color: Color.fromARGB(255, 209, 137, 235),
                        fontSize: 30),
                  ),
                );
              } else {
                List<Map<String, dynamic>> companions = snapshot.data!;
                return Row(
                  children: List.generate(
                    companions.length,
                    (index) {
                      final companion = companions[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 209, 137, 235),
                              maxRadius: 29,
                              child: Text(
                                companion['name'][0],
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              companion['name'],
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 209, 137, 235)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
