import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:traverse_1/custom_widgets/trip_widgets/companiens_add.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/expenses_model.dart';
import 'package:traverse_1/data/models/trip/feedback_model.dart';
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
/////////////////////////////////////////////////////////media//////////////////////////////////////////////////...................
      await db.execute('''CREATE TABLE media(
            id INTEGER PRIMARY KEY,
            userID INTEGER ,
            tripID INTEGER ,
            mediaPic TEXT )''');
/////////////////////////////////////////////////////////expenses/////////////////////////////////////////////////................
      await db.execute('''CREATE TABLE expense(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userID INTEGER ,
            tripID INTEGER ,
            reason TEXT ,
            sponsor TEXT,
            amount INTEGER)''');
      await db.execute(
          '''CREATE TABLE feedbacktable (id INTEGER PRIMARY KEY, tripID INTEGER, feedback TEXT, feedbackdate TEXT, imagepath TEXT)''');
    },
  );
}

//////////////////////////////////////////////adding companien/////////////////////////
Future<void> addCompanions(Map<String, dynamic> companion, int tripId) async {
  try {
    companion['tripID'] = tripId;
    await db!.insert('companions', companion);
    companionList.clear();
  } catch (e) {
    log(-1);
  }
}

Future<List<Map<String, dynamic>>> getCompanions(int tripId) async {
  return await db!
      .query('companions', where: 'tripID = ?', whereArgs: [tripId]);
}

Future<void> updateCompanion(
    List<Map<String, dynamic>> editcontactlist, int id) async {
  try {
    for (var companion in editcontactlist) {
      await addCompanions(companion, id);
      checkDatabase();
    }
  } catch (e) {
    log(-1);
  }
}

Future<void> checkDatabase() async {
  // ignore: unused_local_variable
  List<Map<String, dynamic>> companionsData =
      await db!.rawQuery('SELECT * FROM companions');
  // log(companionsData as num);
  // Print the fetched data
}

////////////////////////...............................mediaadding.......................///////////////////////
Future<int?> addMediapics(MediaModel value) async {
  final id = await db?.rawInsert(
      'INSERT INTO media (userID,tripID,mediaPic) VALUES(?,?,?)',
      [value.userId, value.tripId, value.mediaImage]);
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
      return mediapic;
    } else {
      return null;
    }
  } catch (e) {
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
        value.reason,
        value.sponsor,
        value.amount,
      ],
    );
    return id ?? 0;
  } catch (e) {
    return -1;
  }
}

////////////////////////////////////////////////////editingfuntion/////////////////////////

Future<void> editingExpense({
  required String reason,
  required String sponsor,
  required int amount,
  required int expenseId,
}) async {
  try {
    await db?.rawUpdate(
      'UPDATE expense SET reason = ?, sponsor = ?, amount = ? WHERE id = ?',
      [reason, sponsor, amount, expenseId],
    );
  } catch (e) {
    log(-1);
  }
}

Future<void> deletingexpense(int expenseId) async {
  await db!.delete('expense', where: 'id = ?', whereArgs: [expenseId]);
}

//////////////////////////////////////////////geting//////////////////////////////////////
Future<List<Map<String, dynamic>>?> getExpenses(int tripid) async {
  List<Map<String, dynamic>> expenses =
      await db!.query('expense', where: 'tripID=?', whereArgs: [tripid]);
  if (expenses.isNotEmpty) {
    return expenses;
  }
  return null;
}

/////////////////////////////////////////
Future<int> getTotalExpense(int tripId) async {
  List<Map<String, dynamic>> expenses =
      await db!.query('expense', where: 'tripID = ?', whereArgs: [tripId]);
  num total = 0;
  for (int i = 0; i < expenses.length; i++) {
    total += expenses[i]['amount'];
  }
  return total.toInt();
}

Future<int> getbalance(int tripId) async {
  final expense = await getTotalExpense(tripId);
  final List<Map<String, dynamic>> expenses = await tripdb!.rawQuery(
    'SELECT budget FROM tripdata WHERE id = ?',
    [tripId],
  );

  if (expenses.isNotEmpty) {
    final trip = expenses.first;
    final budget = trip['budget'] as double;
    final balance = (budget - expense).toInt();
    return balance;
  } else {
    return -1;
  }
}

/////////////////////////////////////////////feedback adding session ...............////////////////////////////////////
Future<int> feedbckadding(FeedbackModel values, int tripId) async {
  try {
    final id = await db!.insert('feedbacktable', {
      'tripID': tripId,
      'feedback': values.feedback,
      'feedbackdate': values.feedbackdate,
      'imagepath': values.imagepath
    });
    return id;
  } catch (e) {
    throw Exception('Failed to add feedback');
  }
}

Future<List<Map<String, dynamic>>> getfeedback(int tripid) async {
  List<Map<String, dynamic>> feedbackList = [];
  try {
    feedbackList = await db!
        .query('feedbacktable', where: 'tripID = ?', whereArgs: [tripid]);
    return feedbackList;
  } catch (e) {
    return feedbackList;
  }
}

Future<void> deletefeedback(int feedbackid) async {
  await db!.delete('feedbacktable', where: 'id = ?', whereArgs: [feedbackid]);
}
