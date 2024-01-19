// ignore_for_file: invalid_use_of_protected_member
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      db.execute(
          'CREATE TABLE coverimage (id INTEGER PRIMARY KEY, tripID INTEGER, imagePath TEXT)');
    },
  );
}

////////////////////////////////////////////trip data adding ///////////////////////////////////////////////
Future<int> tripAdding(
  Tripmodel tripModel,
  List<Map<String, dynamic>> companionList,
  List<File> selectedImages,
) async {
  try {
    final tripValues = {
      'userid': tripModel.userid,
      'id': tripModel.id,
      'tripname': tripModel.tripname,
      'destination': tripModel.destination,
      'budget': tripModel.budget,
      'transport': tripModel.transport,
      'triptype': tripModel.triptype,
      'startingDate': tripModel.startingDate,
      'endingDate': tripModel.endingDate,
    };
    int tripId = await tripdb!.insert('tripdata', tripValues);

    if (tripId > 0) {
      final companionFuture = Future.wait(companionList.map((companion) async {
        companion['tripID'] = tripId;
        return addCompanions(companion, tripId);
      }));
      final imagesFuture = Future.wait(selectedImages.map((imagePath) async {
        await addCoverImage(tripId, imagePath);
      }));
      // Wait for both companions and images insertion to complete
      await Future.wait([companionFuture, imagesFuture]);
      await getalltrip(tripModel.userid!);
    }
    return tripId;
  } catch (e) {
    return -1;
  }
}

Future<void> addCoverImage(int tripId, File imagePathFile) async {
  try {
    String imagePathValue = imagePathFile.path.toString();
    final imageValue = {
      'tripID': tripId,
      'imagePath': imagePathValue,
    };
    await tripdb!.insert('coverimage', imageValue);
  } catch (e) {
    log(-1);
  }
}

Future<List<String>> getCoverImages(int tripId) async {
  try {
    final result = await tripdb!
        .query('coverimage', where: 'tripID = ?', whereArgs: [tripId]);
    final List<String> coverImagePaths = [];
    for (var data in result) {
      coverImagePaths.add(data['imagePath'].toString());
    }
    return coverImagePaths;
  } catch (e) {
    return [];
  }
}

Future<void> updateImagesInDatabase(
    int tripId, List<File> newlySelectedImages) async {
  try {
    await deleteExistingImagesFromDatabase(tripId);
    // Loop through newlySelectedImages and add images one by one
    for (var image in newlySelectedImages) {
      await addCoverImage(tripId, image);
    }
  } catch (e) {
    log(e as num);
  }
}

Future<void> deleteExistingImagesFromDatabase(int tripId) async {
  try {
    // Delete existing images associated with the trip
    await tripdb!
        .delete('coverimage', where: 'tripID = ?', whereArgs: [tripId]);
  } catch (e) {
    // Handle error as needed
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
  // ignore: invalid_use_of_visible_for_testing_member
  tripdatas.notifyListeners();
  return tripList;
}

///////////////////////////////////////editing trip///////////////////////////////////////
Future<int> editTrip(
  tripname,
  destination,
  budget,
  transport,
  triptype,
  coverpic,
  startingDate,
  endingDate,
  id,
  userid,
  List<XFile> newlySelectedImages,
  List<Map<String, dynamic>> editcontactlist,
) async {
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
    await updateImagesInDatabase(id, convertXFilesToFiles(newlySelectedImages));
    await updateCompanion(editcontactlist, id);
    return rowsAffected;
  } catch (e) {
    return -1;
  }
}

List<File> convertXFilesToFiles(List<XFile> xFiles) {
  List<File> files = [];
  for (var xFile in xFiles) {
    files.add(File(xFile.path));
  }
  return files;
}

///////////////////////
Future<void> printExistingRecords() async {
  await tripdb!.query('tripdata');
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
    return [];
  }
}

//////////////////////////////////////////////////ongoingtrip////////////////////////////////////////////
Future<List<Tripmodel>> getOngoingTrips(int userId) async {
  List<Tripmodel> ongoingTrips = [];
  DateTime currentDate = DateTime.now();
  String convertedDate = DateFormat('dd-MMM-yyyy').format(currentDate);

  var trips = await tripdb!.query('tripdata',
      where: 'userid=? AND startingDate <=? AND endingDate >=?',
      whereArgs: [userId, convertedDate, convertedDate]);

  tripdatas.value.clear();

  for (var map in trips) {
    if (map['startingDate'] != null) {
      Tripmodel obj = Tripmodel.fromMap(map);

      List<String> coverImagePaths = await getCoverImages(obj.id!);
      obj.imagePaths = coverImagePaths;

      ongoingTrips.add(obj);
    }
  }
  ongoingTrips.sort((a, b) => a.startingDate.compareTo(b.startingDate));
  return ongoingTrips;
}

Future<List<Tripmodel>> getUpcomingTrip(int userid) async {
  List<Tripmodel> tripsList = [];
  DateTime currentDate = DateTime.now();
  String formattedCurrentDate = DateFormat('dd-MMM-yyyy').format(currentDate);
  List<Map<String, dynamic>> trips = await tripdb!.query('tripdata',
      where: 'userid=? AND startingDate > ?',
      whereArgs: [userid, formattedCurrentDate]);
  for (var tripData in trips) {
    Tripmodel trip = Tripmodel.fromMap(tripData);

    tripsList.add(trip);
  }
  return tripsList;
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
      tripsList.add(trip);
    }
  }

  return tripsList;
}
