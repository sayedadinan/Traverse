import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/view/screens/trip_details/trip_details_page.dart';

class ScreenSearch extends StatefulWidget {
  final Tripmodel? trip;
  final int userId;
  const ScreenSearch({
    Key? key,
    this.trip,
    required this.userId,
  }) : super(key: key);

  @override
  ScreenSearchState createState() => ScreenSearchState();
}

class ScreenSearchState extends State<ScreenSearch> {
  final searchResult = ValueNotifier<List<Tripmodel>>([]);
  List<Tripmodel> allTrips = [];

  @override
  void initState() {
    super.initState();
    getTrips();
    initializationtrip();
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: screensize.height * 0.02,
              ),
              TextFormField(
                onChanged: (value) {
                  searchResult.value = allTrips
                      .where((trip) => trip.tripname
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal[10],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Search your trips',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              SizedBox(
                height: screensize.height * 0.02,
              ),
              Expanded(
                child: ValueListenableBuilder<List<Tripmodel>>(
                  valueListenable: searchResult,
                  builder: (context, value, _) {
                    return value.isEmpty
                        ? const Center(
                            child: Text(
                              'Now result found',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : ListView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: value.length,
                            itemBuilder: (context, index) => Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                onTap: () {
                                  final userId = value[index].userid;
                                  if (userId != null) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (ctx) => Tripdetails(
                                        trip: value[index],
                                      ),
                                    ));
                                  } else {}
                                },
                                title: Text(value[index].tripname),
                                subtitle: Text(value[index].destination),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTrips() async {
    allTrips = await getalltrip(widget.userId);
    searchResult.value = List<Tripmodel>.from(allTrips);
  }
}
