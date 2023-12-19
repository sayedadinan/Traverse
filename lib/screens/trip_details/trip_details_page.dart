import 'dart:io';

import 'package:flutter/material.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

class Tripdetails1 extends StatefulWidget {
  const Tripdetails1({
    Key? key,
    required this.trip,
  }) : super(key: key);

  final Tripmodel trip;

  @override
  State<Tripdetails1> createState() => _Tripdetails1State();
}

class _Tripdetails1State extends State<Tripdetails1>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 58, 239),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.trip.tripname,
          style: const TextStyle(color: Colors.amber, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: 370,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: widget.trip.coverpic != null &&
                              File(widget.trip.coverpic!).existsSync()
                          ? FileImage(File(widget.trip.coverpic!))
                              as ImageProvider<Object>
                          : const AssetImage(
                              'assets/placeholder for traverse.jpg',
                            ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.trip.destination,
                    style: const TextStyle(fontSize: 28, color: Colors.amber),
                  ),
                  Text(
                    widget.trip.startingDate,
                    style: const TextStyle(fontSize: 28, color: Colors.amber),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 23),
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.amber,
                  labelStyle: TextStyle(fontSize: 25),
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Media'),
                    Tab(text: 'Details'),
                    Tab(text: 'Expenses'),
                  ],
                ),
              ),
            ),
            Container(
              height: 800, // Adjust height as needed
              child: TabBarView(
                controller: tabController,
                children: [
                  Container(
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Starting date',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Starting date',
                              style:
                                  TextStyle(fontSize: 28, color: Colors.amber),
                            ),
                            SizedBox(
                              width: 39,
                            ),
                            Text(
                              'Ending date',
                              style:
                                  TextStyle(fontSize: 28, color: Colors.amber),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.trip.startingDate,
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.amber),
                              ),
                              const SizedBox(
                                width: 39,
                              ),
                              Text(
                                widget.trip.endingDate,
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.amber),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 39),
                          child: Container(
                            width: 170,
                            height: 160,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber),
                                borderRadius: BorderRadius.circular(19)),
                            child: Column(
                              children: [
                                const Text(
                                  'Trip',
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 24),
                                ),
                                const Text(
                                  'Budget',
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 24),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '₹' + widget.trip.budget.toString(),
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.amber),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Balance:',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.amber),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Travel Type',
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 29),
                            ),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    minimumSize:
                                        MaterialStatePropertyAll(Size(0, 18))),
                                onPressed: () {},
                                child: Text(widget.trip.triptype))
                            // Text(
                            //   widget.trip.triptype,
                            //   style:
                            //       TextStyle(color: Colors.amber, fontSize: 25),
                            // )
                          ],
                        ),
                        Divider(
                          thickness: 3,
                          indent: 25,
                          endIndent: 25,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Starting date',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                  // Text('Details'),
                  // Text('Media'),
                  // Text('Expenses'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
