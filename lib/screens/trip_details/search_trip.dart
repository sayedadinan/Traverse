import 'dart:io';

import 'package:flutter/material.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:traverse_1/screens/trip_details/trip_details_page.dart';

class ScreenSearch extends StatefulWidget {
  // final UserModel user;
  final Tripmodel? trip;
  final int userId;
  const ScreenSearch({
    Key? key,
    this.trip,
    required this.userId, // Fix the key parameter
    // required this.user,
  }) : super(key: key);

  @override
  _ScreenSearchState createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
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
                                      builder: (ctx) => Tripdetails1(
                                        trip: value[index],
                                      ),
                                    ));
                                  } else {
                                    print(
                                        'Error: The trip or user ID is null.');
                                  }
                                },
                                leading: CircleAvatar(
                                  backgroundImage: value[index].coverpic != null
                                      ? FileImage(
                                          File(value[index].coverpic),
                                        ) as ImageProvider<Object>
                                      : const AssetImage(
                                          'assets/placeholder for traverse.jpg'),
                                  backgroundColor: Colors.grey[300],
                                ),
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
// class ScreenSearch extends StatefulWidget {
//   final Tripmodel? trip;

//   const ScreenSearch({
//     Key? key,
//     this.trip,
//   }) : super(key: key);

//   @override
//   _ScreenSearchState createState() => _ScreenSearchState();
// }

// class _ScreenSearchState extends State<ScreenSearch> {
//   final searchResult = ValueNotifier<List<Tripmodel>>([]);
//   List<Tripmodel> allTrips = [];

//   @override
//   Widget build(BuildContext context) {
//     final Size screensize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               SizedBox(height: screensize.height * 0.02),
//               TextFormField(
//                 onChanged: (value) {
//                   setState(() {
//                     searchResult.value = allTrips
//                         .where((trip) => trip.tripname
//                             .toLowerCase()
//                             .contains(value.toLowerCase()))
//                         .toList();
//                   });
//                 },
//                 // onChanged: (value) async {
//                 //   if (value.isNotEmpty) {
//                 //     final results = await searchTripsByName(
//                 //       value,
//                 //       widget.trip?.userid ?? 0,
//                 //     );
//                 //     searchResult.value = results;
//                 //   } else {
//                 //     searchResult.value = [];
//                 //   }
//                 // },
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: const Color.fromARGB(172, 158, 158, 158),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   hintText: 'Searching...',
//                   prefixIcon: const Icon(Icons.search),
//                 ),
//               ),
//               SizedBox(height: screensize.height * 0.02),
//               Expanded(
//                 child: ValueListenableBuilder<List<Tripmodel>>(
//                   valueListenable: searchResult,
//                   builder: (context, value, _) {
//                     return value.isEmpty
//                         ? Center(
//                             child: Text(
//                               'No results found',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           )
//                         : ListView.builder(
//                             itemCount: value.length,
//                             itemBuilder: (context, index) => ListTile(
//                               title: Text(value[index].tripname),
//                               subtitle: Text(value[index].destination),
//                             ),
//                           );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:traverse_1/data/functions/tripdata.dart';
// import 'package:traverse_1/data/models/trip/trip_model.dart';
// import 'package:traverse_1/screens/trip_details/trip_details_page.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({
//     Key? key,
//     this.trip,
//     this.profileid,
//   }) : super(key: key);
//   final Tripmodel? trip;
//   final int? profileid;
//   // final int userid;
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Tripmodel> searchResults = [];
//   bool isSearching = false;

//   @override
//   void initState() {
//     super.initState();
//     initializationtrip(); // Initialize the database
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Trips'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search by trip name',
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.search),
//                   onPressed: () {
//                     search();
//                   },
//                 ),
//               ),
//               onChanged: (value) {
//                 if (value.isNotEmpty) {
//                   search();
//                 }
//               },
//             ),
//             const SizedBox(height: 20),
//             isSearching
//                 ? const CircularProgressIndicator()
//                 : Expanded(
//                     child: searchResults.isNotEmpty
//                         ? ListView.builder(
//                             itemCount: searchResults.length,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   // Navigate to the details page or perform an action when tapping the list item
//                                   // Replace the below navigation logic with your desired action
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (ctx) => Tripdetails1(
//                                       trip: searchResults[index],
//                                     ),
//                                   ));
//                                 },
//                                 child: Card(
//                                   elevation: 4,
//                                   margin:
//                                       const EdgeInsets.symmetric(vertical: 8),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: ListTile(
//                                     leading: CircleAvatar(
//                                       backgroundImage: searchResults[index]
//                                                   .coverpic !=
//                                               null
//                                           ? FileImage(
//                                               File(searchResults[index]
//                                                   .coverpic!),
//                                             ) as ImageProvider<Object>
//                                           : const AssetImage(
//                                               'assets/placeholder for traverse.jpg'),
//                                       backgroundColor: Colors.grey[300],
//                                     ),
//                                     title: Text(searchResults[index].tripname),
//                                     subtitle:
//                                         Text(searchResults[index].destination),
//                                     // Add any other trip details here as needed
//                                   ),
//                                 ),
//                               );
//                             },
//                           )
//                         : const Center(
//                             child: Text('No results found'),
//                           ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   void search() async {
//     setState(() {
//       isSearching = true;
//     });

//     final String searchTerm = _searchController.text.trim();
//     final int userId = widget.userid; // Replace this with the actual user ID

//     if (searchTerm.isNotEmpty) {
//       List<Tripmodel> results = await searchTripsByName(searchTerm, userId);

//       setState(() {
//         searchResults = results;
//         isSearching = false;
//       });
//     } else {
//       setState(() {
//         searchResults.clear();
//         isSearching = false;
//       });
//     }
//   }
// }
