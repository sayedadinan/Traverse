import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:traverse_1/data/models/trip/expenses_model.dart';
import 'package:traverse_1/data/models/trip/media_model.dart';

ValueNotifier<List<ExpenseModel>> propertydata =
    ValueNotifier<List<ExpenseModel>>([]);
Database? db;
Future<void> initproperties() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = await openDatabase(
    'propertiestrip',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE companions (id INTEGER PRIMARY KEY, name TEXT, number TEXT, tripID INTEGER)');
/////////////////////////////////////////////////////////media//////////////////////////////////////////////////
      await db.execute('''CREATE TABLE media(
            id INTEGER PRIMARY KEY,
            userID INTEGER ,
            tripID INTEGER ,
            mediaPic TEXT )''');
/////////////////////////////////////////////////////////expenses///////////////////////////////////////////////////////////
      await db.execute('''CREATE TABLE expense(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userID INTEGER ,
            tripID INTEGER ,
            reason TEXT ,
            sponsor TEXT,
            amount INTEGER)''');
    },
  );
}

//////////////////////////////////////////////adding companien/////////////////////////
addCompanions(Map<String, dynamic> companion) async {
  db!.insert('companions', companion);
}

////////////////////////...............................mediaadding.......................///////////////////////
Future<int?> addMediapics(MediaModel value) async {
  final id = await db?.rawInsert(
      'INSERT INTO media (userID,tripID,mediaPic) VALUES(?,?,?)',
      [value.userId, value.tripId, value.mediaImage]);
  print('pic aded');
  return id;
}

//////////////////////////////////////.................get media pics....................///////////////////////////////////////
Future<List<Map<String, dynamic>>?> getmediapics(int tripId) async {
  try {
    final List<Map<String, dynamic>> mediapic = await db!.query(
      'media',
      where: 'tripID = ?',
      whereArgs: [tripId],
    );

    if (mediapic.isNotEmpty) {
      print('Pictures found');
      print(mediapic);
      return mediapic;
    } else {
      print('No pictures found');
      return null;
    }
  } catch (e) {
    print('Error getting media pics: $e');
    return null;
  }
}

////////////////////////////////////////////..............media deleting.................////////////////////////////////////////////
deletemedia(int? mediaid) async {
  await db!.rawDelete('DELETE FROM media WHERE id = ?', [mediaid]);
}

//////////////////////////////..........................expenses adding .........................///////////////////////////////

Future<int> addExpense(ExpenseModel value) async {
  try {
    final id = await db?.rawInsert(
      'INSERT INTO expense (userID, tripID, reason, sponsor, amount) VALUES (?, ?, ?, ?, ?)',
      [
        value.userId,
        value.tripID,
        value.sponsor,
        value.amount,
        value.reason,
      ],
    );
    print('Added to db');
    print('Expense to add: $value');
    print('Added expense with ID: $id');
    return id ?? 0; // Return 0 or a default value if id is null
  } catch (e) {
    print('Error adding expense: $e');
    return -1; // Return null in case of an error
  }
}

Future<List<Map<String, dynamic>>?> getExpenses(int tripid) async {
  List<Map<String, dynamic>> expenses =
      await db!.query('expense', where: 'tripID=?', whereArgs: [tripid]);
  // propertydata.value = [];
  // for (var data in expenses) {
  //   final value = ExpenseModel.fromMap(data);
  //   propertydata.value.add(value);
  // }
  // propertydata.notifyListeners();
  if (expenses.isNotEmpty) {
    return expenses;
  }
  return null;
}

Future<int> getTotalExpense(int tripId) async {
  List<Map<String, dynamic>> expenses =
      await db!.query('expense', where: 'tripID = ?', whereArgs: [tripId]);
  num total = 0;
  for (int i = 0; i < expenses.length; i++) {
    total += expenses[i]['amount'];
  }
  return total.toInt();
}

Future<int> getbalance(int tripid) async {
  final expense = await getTotalExpense(tripid);
  final List<Map<String, dynamic>> tripList =
      await db!.query("tripdata", where: 'id = ?', whereArgs: [tripid]);
  final trip = tripList.first;
  final budget = int.parse(trip['budget']);
  final balance = budget - expense;
  return balance;
}
