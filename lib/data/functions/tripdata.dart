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
          'CREATE TABLE tripdata (id INTEGER PRIMARY KEY, tripname TEXT, destination TEXT, budget REAL, transport TEXT, triptype TEXT, coverpic TEXT, startingDate TEXT, endingDate TEXT)');
    },
  );
}

////////////////////////////////////////////trip data adding ///////////////////////////////////////////////

Future<int> tripadding(Tripmodel tripmodel) async {
  try {
    final tripValues = {
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
    if (a != null && a > 0) {
      print('Successfully added');
    } else {
      print('Failed to add');
    }
    return a;
  } catch (e) {
    print('Error adding trip to db: $e');
    return -1;
  }
}

////////////////////////////////////getalldata from tripdata//////////////////////////////////

Future<void> getalltrip(int id) async {
  final result = await tripdb!.query('tripdata');
  tripdatas.value = [];
  for (var data in result) {
    final trip = Tripmodel.fromMap(data);
    tripdatas.value.add(trip);
  }
  tripdatas.notifyListeners();
}
