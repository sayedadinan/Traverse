import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:traverse_1/components/trip_widgets/details_tab.dart';
import 'package:traverse_1/components/trip_widgets/expense_detail.dart';
import 'package:traverse_1/components/trip_widgets/feedback_details.dart';
import 'package:traverse_1/components/trip_widgets/media_widget.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/view/screens/trip_details/trip_details_page.dart';

class tripdetails_showing extends StatelessWidget {
  const tripdetails_showing({
    super.key,
    required this.screenSize,
    required this.widget,
    required this.tabController,
  });

  final Size screenSize;
  final Tripdetails widget;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: screenSize.height * 0.02),
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
                  height: screenSize.height * 0.2,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: snapshot.data!.length > 1,
                  // autoPlay: true,
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
          height: screenSize.height * 0.04,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'To :  ${widget.trip.destination.toUpperCase()}',
                style: const TextStyle(fontSize: 23, color: Colors.amber),
              ),
              Text(
                widget.trip.startingDate,
                style: const TextStyle(fontSize: 23, color: Colors.amber),
              ),
            ],
          ),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 23),
            child: TabBar(
              controller: tabController,
              labelColor: Colors.amber,
              labelStyle: const TextStyle(fontSize: 22),
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Details'),
                Tab(text: 'Expenses'),
                Tab(text: 'Media'),
                Tab(text: 'Feedback')
              ],
            ),
          ),
        ),
        SizedBox(
          height: 700,
          child: TabBarView(
            controller: tabController,
            children: [
              Detailstab(
                trip: widget.trip,
              ),
              Expensedetails(
                trip: widget.trip,
              ),
              Mymedia(
                trip: widget.trip,
              ),
              Feedbackdetails(
                trip: widget.trip,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
