import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:traverse_1/data/functions/properties_trip.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';
import 'package:intl/intl.dart';

ValueNotifier<List<Tripmodel>> tripdatas = ValueNotifier<List<Tripmodel>>([]);
ValueNotifier<List<Tripmodel>> ongoingtrip = ValueNotifier<List<Tripmodel>>([]);
Database? tripdb;
Future<dynamic> initializationtrip() async {
  tripdb = await openDatabase(
    'tripdb',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE tripdata (id INTEGER PRIMARY KEY, tripname TEXT, destination TEXT, budget REAL, transport TEXT, triptype TEXT, coverpic TEXT, startingDate TEXT, endingDate TEXT, userid INTEGER)');
    },
  );
}

////////////////////////////////////////////trip data adding ///////////////////////////////////////////////

Future<int> tripadding(
    Tripmodel tripmodel, List<Map<String, dynamic>> companionList) async {
  try {
    final tripValues = {
      'userid': tripmodel.userid,
      'id': tripmodel.id,
      'tripname': tripmodel.tripname,
      'destination': tripmodel.destination,
      'budget': tripmodel.budget,
      'transport': tripmodel.transport,
      'triptype': tripmodel.triptype,
      'coverpic': tripmodel.coverpic,
      'startingDate': tripmodel.startingDate,
      'endingDate': tripmodel.endingDate,
    };
    int tripId = await tripdb!.insert('tripdata', tripValues);

    if (tripId > 0) {
      for (var companion in companionList) {
        companion['tripID'] = tripId;

        // Insert companion data into 'companions' table
        await addCompanions(companion);
      }
      await getalltrip(tripmodel.userid!);
    }
    return tripId;
  } catch (e) {
    print('Error adding trip to db: $e');
    return -1;
  }
}

Future<void> updateCompanionData(
    int tripId, int companionId, Map<String, dynamic> updatedData) async {
  try {
    // Update companion data in the database based on tripId and companionId
    await tripdb!.update('companions', updatedData,
        where: 'tripID = ? AND id = ?', whereArgs: [tripId, companionId]);

    print('Companion data updated successfully');
  } catch (e) {
    print('Error updating companion data: $e');
  }
}
////////////////////////////////////getalldata from tripdata//////////////////////////////////

Future<List<Tripmodel>> getalltrip(int userId) async {
  final result =
      await tripdb!.query('tripdata', where: 'userid = ?', whereArgs: [userId]);
  final List<Tripmodel> tripList = [];
  for (var data in result) {
    final trip = Tripmodel.fromMap(data);
    tripList.add(trip);
  }
  tripdatas.value = tripList;
  tripdatas.notifyListeners();
  return tripList;
}
///////////////////////////////////////editing trip///////////////////////////////////////

Future<int> editTrip(tripname, destination, budget, transport, triptype,
    coverpic, startingDate, endingDate, id, userid) async {
  try {
    final tripValues = {
      'tripname': tripname,
      'destination': destination,
      'budget': budget,
      'transport': transport,
      'triptype': triptype,
      'coverpic': coverpic,
      'startingDate': startingDate,
      'endingDate': endingDate,
      'id': id
    };

    int rowsAffected = await tripdb!.update(
      'tripdata',
      tripValues,
      where: 'id = ?',
      whereArgs: [id],
    );

    print('Rows affected in the database: $rowsAffected');

    return rowsAffected;
  } catch (e) {
    print('Error editing trip in db: $e');
    return -1;
  }
}

///////////////////////
Future<void> printExistingRecords() async {
  final result = await tripdb!.query('tripdata');
  print('Existing Records:');
  for (var record in result) {
    print(record); // Print each record in the table
  }
}

////////////////////////////////////////delete trip ///////////////////////////////////////////////////...........................
Future<void> deletetrip(id, userid) async {
  await tripdb!.delete(
    'tripdata',
    where: 'id = ?',
    whereArgs: [id],
  );

  await getalltrip(userid);
}

//////////////////////////////////////searchquery///////////////////////////////////

Future<List<Tripmodel>> searchTripsByName(String searchTerm, int userId) async {
  List<Tripmodel> searchResults = [];
  print('Search used');
  try {
    final result = await tripdb!.query(
      'tripdata',
      where: 'userid = ? AND tripname LIKE ?',
      whereArgs: [userId, '%$searchTerm%'],
    );

    for (var data in result) {
      final trip = Tripmodel.fromMap(data);
      searchResults.add(trip);
    }

    return searchResults;
  } catch (e) {
    print('Error searching trips in db: $e');
    return []; // Return an empty list in case of an error
  }
}

//////////////////////////////////////////////////ongoingtrip////////////////////////////////////////////
Future<List<Tripmodel>> getOngoingTrips(int userId) async {
  List<Tripmodel> ongoingTrips = [];
  DateTime currentDate = DateTime.now();
  String convertedDate =
      DateFormat('dd-MMM-yyyy').format(currentDate); // Change date format

  var trips = await tripdb!.query('tripdata',
      where: 'userid=? AND startingDate <=? AND endingDate >=?',
      whereArgs: [userId, convertedDate, convertedDate]);
  print("trips ongoing $trips");
  tripdatas.value.clear();
  for (var map in trips) {
    if (map['startingDate'] != null) {
      Tripmodel obj = Tripmodel.fromMap(map);

      // Fetch companions for this trip and add them to obj
      // var companions =
      //     await db!.query('companions', where: 'id = ?', whereArgs: [obj.id]);

      // obj.companions = companions
      //     .map((companionMap) => CompanionModel.fromJson(companionMap))
      //     .toList();

      ongoingTrips.add(obj); // Add the ongoing trip to the list
    }
  }

  // Sort ongoing trips by startingDate
  ongoingTrips.sort((a, b) => a.startingDate.compareTo(b.startingDate));

  return ongoingTrips;
}

Future<List<Tripmodel>> getUpcomingTrip(int userid) async {
  List<Tripmodel> tripsList = [];

  DateTime currentDate = DateTime.now();
  String formattedCurrentDate = DateFormat('dd-MMM-yyyy').format(currentDate);

  // Adjust the SQL query to fetch trips with a starting date strictly after the current date
  List<Map<String, dynamic>> trips = await tripdb!.query('tripdata',
      where: 'userid=? AND startingDate > ?',
      whereArgs: [userid, formattedCurrentDate]);
  print("trips upcoming$trips");

  // Iterate through fetched data and convert to Tripmodel objects
  for (var tripData in trips) {
    Tripmodel trip = Tripmodel.fromMap(tripData);

    tripsList.add(trip);
  }

  return tripsList; // Return the list of Tripmodels
}

//////////////////////////////////////////////////getrecent///////////////////////////////////
Future<List<Tripmodel>> getRecentTrip(int userid) async {
  List<Tripmodel> tripsList = [];

  DateTime currentDate = DateTime.now();
  String convertedDate =
      DateFormat('dd-MMM-yyyy').format(currentDate); // Change date format

  List trips = await tripdb!.query('tripdata',
      where: 'userid=? AND endingDate <= ?',
      whereArgs: [userid, convertedDate]);

  for (var map in trips) {
    if (map['endingDate'] != null) {
      Tripmodel trip = Tripmodel.fromMap(map);

      // Fetch companions for this trip and add them to obj
      tripsList.add(trip);
    }
  }

  return tripsList;
}
