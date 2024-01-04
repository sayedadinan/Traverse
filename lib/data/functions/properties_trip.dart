import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:traverse_1/data/functions/tripdata.dart';
import 'package:traverse_1/data/models/trip/expenses_model.dart';
import 'package:traverse_1/data/models/trip/media_model.dart';

// import 'package:traverse_1/data/functions/tripdata.dart';

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

Future<List<Map<String, dynamic>>> getCompanions(int tripId) async {
  return await db!
      .query('companions', where: 'tripID = ?', whereArgs: [tripId]);
}

Future<void> editCompanionList(List<Map<String, dynamic>> companionList) async {
  try {
    for (var companionData in companionList) {
      // Check if the 'id' field exists in the companionData map
      if (companionData.containsKey('id')) {
        String companionId = companionData['id'];
        companionData.remove('id'); // Remove the ID from the data to update

        // Perform the update for each companion using its ID and updated data
        await db!.update('companions', companionData,
            where: 'id = ?', whereArgs: [companionId]);
      } else {
        throw Exception("Error: 'id' field is missing in companion data.");
        // You might want to throw an exception or handle the missing 'id' field accordingly
      }
    }
    print('Companion data updated successfully');
  } catch (e) {
    print('Error editing companions: $e');
  }
}

// Future<void> updateCompanionDetailsForTrip(
//     int tripId, Map<String, dynamic> companion) async {
//   try {
//     companion['tripID'] = tripId;
//     // Your implementation to update companion details in the 'companions' table
//     // Update the companion's details and associate it with the provided trip ID
//     // For example:
//     await db!.update('companions', companion,
//         where: 'id = ? AND tripID = ?', whereArgs: [companion['id'], tripId]);
//   } catch (e) {
//     print('Error updating companion details for trip: $e');
//     rethrow; // You might want to handle this error appropriately
//   }
// }
Future<void> updateCompanionDetailsForTrip(
    int tripId, Map<String, dynamic> companion) async {
  try {
    // Create a new modifiable map based on the contents of the original companion map
    Map<String, dynamic> updatedCompanion = Map.from(companion);

    // Modify the updatedCompanion map as needed
    updatedCompanion['tripID'] = tripId;

    // Perform the update using the updatedCompanion map
    await db!.update(
      'companions',
      updatedCompanion,
      where: 'id = ? AND tripID = ?',
      whereArgs: [updatedCompanion['id'], tripId],
    );
  } catch (e) {
    print('Error updating companion details for trip: $e');
    rethrow; // You might want to handle this error appropriately
  }
}

////////////////////////...............................mediaadding.......................///////////////////////
Future<int?> addMediapics(MediaModel value) async {
  final id = await db?.rawInsert(
      'INSERT INTO media (userID,tripID,mediaPic) VALUES(?,?,?)',
      [value.userId, value.tripId, value.mediaImage]);
  // print('pic aded');
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
      // print('Pictures found');
      // print(mediapic);
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
        value.reason,
        value.sponsor,
        value.amount,
      ],
    );
    // print('Added to db');
    // print('Expense to add: $value');
    // print('Added expense with ID: $id');
    return id ?? 0; // Return 0 or a default value if id is null
  } catch (e) {
    print('Error adding expense: $e');
    return -1; // Return null in case of an error
  }
}

////////////////////////////////////////////////////editingfuntion/////////////////////////

Future<void> editingExpense({
  required String reason,
  required String sponsor,
  required int amount,
  required int expenseId, // Pass the unique expense ID
}) async {
  try {
    await db?.rawUpdate(
      'UPDATE expense SET reason = ?, sponsor = ?, amount = ? WHERE id = ?',
      [reason, sponsor, amount, expenseId], // Use the unique expense ID here
    );
    print('Expense edited');
  } catch (e) {
    print('Error editing expense: $e');
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
    final budget =
        trip['budget'] as double; // Assuming budget is of type double
    final balance = (budget - expense).toInt();
    return balance;
  } else {
    // Handle cases where the 'tripId' doesn't exist or the result is empty
    return -1; // For example, returning -1 to indicate an error or absence of data
  }
}
