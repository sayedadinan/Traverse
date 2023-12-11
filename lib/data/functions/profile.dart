import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:traverse_1/data/models/profile/user.dart';

ValueNotifier<List<Profile>> profileList = ValueNotifier<List<Profile>>([]);
ValueNotifier<List<Profile>> profileData = ValueNotifier<List<Profile>>([]);
late Database profileDB;
Future<dynamic> initializeProfileDB() async {
  profileDB = await openDatabase(
    'profileDB',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE profile(id INTEGER PRIMARY KEY,imagex TEXT,username TEXT,email TEXT,password TEXT,islogin INTEGER)');
    },
  );
}

Future<void> refreshdata() async {
  final result = await profileDB.rawQuery('SELECT * FROM profile');
  profileList.value.clear();
  for (var map in result) {
    final student = Profile.fromMap(map);
    profileList.value.add(student);
  }
  // profileList.notifyListeners();
}

Future<void> refreshRefreshid(int id) async {
  final profiledata = await profileDB
      .rawQuery("SELECT * FROM profile WHERE id = ?", [id.toString()]);
  profileData.value.clear();
  for (var map in profiledata) {
    final student = Profile.fromMap(map);
    profileData.value.add(student);
  }
  // profileData.notifyListeners();
}

///////////////////////////////////Data.adding///////////////////////////////////////////////////..................................
// Future<int> addProfile(Profile value) async {
//   try {
//     var a = await profileDB.rawInsert(
//       'INSERT INTO profile (imagex, username, email, password, islogin) VALUES(?,?,?,?)',
//       [value.imagex, value.username, value.email, value.password],
//     );
//     log('settaanu$a');
//     refreshdata();
//     return id;
//   } catch (e) {
//     // Handle any errors that occur during data insertion.
//     log('Error inserting dataaaa: $e');
//   }
// }
Future<int> addProfile(Profile value) async {
  try {
    var a = await profileDB.rawInsert(
      'INSERT INTO profile (imagex, username, email, password, islogin) VALUES(?,?,?,?,?)',
      [value.imagex, value.username, value.email, value.password, 1],
    );
    // log(value.imagex);
    log('settaanu$a');
    await refreshdata(); // Wait for data refresh before returning
    return a; // Return the ID of the inserted row
  } catch (e) {
    // Handle any errors that occur during data insertion.
    log('Error inserting dataaaa: $e');
    return -1; // Return -1 to indicate an error
  }
}

///////////////////////////////////////Editingprofile//////////////////////////////////////////////.................................
Future<void> editProfiledata(id, imagex, username, email, password) async {
  try {
    final dataflow = {
      'imagex': imagex,
      'username': username,
      'email': email,
      'password': password,
    };

    await profileDB.update('profile', dataflow, where: 'id=?', whereArgs: [id]);
    refreshdata();
  } catch (e) {
    log('Error editing data: $e');
  }
}

///////////////////////////////////authentication/////////////////////////////////////////////////////.............................
Future<Profile?> validateprofile(String username, String password) async {
  final List<Map<String, dynamic>> users = await profileDB.query(
    'profile',
    where: 'username = ? AND password = ?',
    whereArgs: [username, password],
  );

  if (users.isNotEmpty) {
    int id = users.first['id'];
    await profileDB.update(
      'profile',
      {'islogin': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    return Profile.fromMap(users.first);
  } else {
    return null;
  }
}

//////////////////////////////////////ifthisusername isthere?/////////////////////////////////////////....................................
Future<bool> checkIfNameExists(String name) async {
  final List<Map<String, dynamic>> users = await profileDB.query(
    'profile',
    where: 'username = ?',
    whereArgs: [name],
  );
  return users.isNotEmpty;
}

////////////////////////////userloggin=1/////////////////.....................
getUserLogged() async {
  final user = await profileDB.query('profile', where: 'isLogin=1', limit: 1);
  if (user.isEmpty) {
    return null;
  } else {
    return Profile.fromMap(user.first);
  }
}

///////////////////////signout///////////////////////////////...................................
signoutUser() async {
  final List<Map<String, dynamic>> user = await profileDB.query('profile',
      where: 'isLogin = ?', whereArgs: [1], limit: 1);
  if (user.isNotEmpty) {
    int id = user.first['id'];
    profileDB.update('profile', {'isLogin': 0},
        where: 'id = ?', whereArgs: [id]);
  }
}
