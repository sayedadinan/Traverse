import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:traverse_1/data/models/trip/trip_model.dart';

ValueNotifier<List<Tripmodel>> tripdatas = ValueNotifier<List<Tripmodel>>([]);
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

Future<int> tripadding(Tripmodel tripmodel) async {
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

    var a = await tripdb!.insert('tripdata', tripValues);
    // if (a != null && a > 0) {
    //   print('Successfully added');
    // } else {
    //   print('Failed to add');
    // }
    return a;
  } catch (e) {
    print('Error adding trip to db: $e');
    return -1;
  }
}

////////////////////////////////////getalldata from tripdata//////////////////////////////////

Future<void> getalltrip(int userId) async {
  final result =
      await tripdb!.query('tripdata', where: 'userid = ?', whereArgs: [userId]);
  tripdatas.value = [];
  for (var data in result) {
    final trip = Tripmodel.fromMap(data);
    tripdatas.value.add(trip);
  }
  tripdatas.notifyListeners();
}

///////////////////////////////////////editing trip///////////////////////////////////////

Future<int> editTrip(tripname, destination, budget, transport, triptype,
    coverpic, startingDate, endingDate, id) async {
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
    // print(id);
    // print('10');
    // print(tripValues);
    await printExistingRecords();
    return await tripdb!.update(
      'tripdata',
      tripValues,
      where: 'id = ?',
      whereArgs: [id],
    );
  } catch (e) {
    print('Error editing trip in db: $e');
    return -1;
  }
}

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
  getalltrip(userid);
}
