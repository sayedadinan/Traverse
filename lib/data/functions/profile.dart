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
  profileList.notifyListeners();
}

Future<void> refreshRefreshid(int id) async {
  final profiledata = await profileDB
      .rawQuery("SELECT * FROM profile WHERE id = ?", [id.toString()]);
  profileData.value.clear();
  for (var map in profiledata) {
    final student = Profile.fromMap(map);
    profileData.value.add(student);
  }
  profileData.notifyListeners();
}

///////////////////////////////////Data.adding///////////////////////////////////////////////////..................................

Future<int> addProfile(Profile value) async {
  try {
    var a = await profileDB.rawInsert(
      'INSERT INTO profile (imagex, username, email, password, islogin) VALUES(?,?,?,?,?)',
      [value.imagex, value.username, value.email, value.password, 1],
    );

    log('settaanu$a');
    return a;
  } catch (e) {
    log('Error inserting dataaaa: $e');
    return -1;
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

    var a = await profileDB
        .update('profile', dataflow, where: 'id=?', whereArgs: [id]);
    refreshdata();
    log(a as String);
  } catch (e) {
    log('Error editing data: $e');
  }
}

///////////////////////////////////authentication/////////////////////////////////////////////////////.............................
Future<Profile?> validateprofile(String username, String password) async {
  final List<Map<String, dynamic>> users = await profileDB.query('profile',
      where: 'username = ? AND password = ?', whereArgs: [username, password]);

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

Future<void> signoutUser() async {
  final List<Map<String, dynamic>> user = await profileDB.query(
    'profile',
    where: 'isLogin = ?',
    whereArgs: [1],
    limit: 1,
  );

  if (user.isNotEmpty) {
    int id = user.first['id'];
    await profileDB.update(
      'profile',
      {'isLogin': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

///////////////////////////getuser//////////////////////////////////////../

Future<void> getprofile(int id) async {
  final data = await profileDB
      .rawQuery("SELECT * FROM profile WHERE id = ?", [id.toString()]);
  profileData.value.clear();
  for (var result in data) {
    final main = Profile.fromMap(result);
    profileData.value.add(main);
  }
  profileData.notifyListeners();
}

///////////////////////////////////////////////////////////////ONLY FOR TEST////////////////////////////////////////////////////////////////////
Future<void> inintdb() async {
  await openDatabase(
    'data',
    version: 1,
    onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE usu(id PRIMARY KEY, username TEXT, age TEX)');
    },
  );
}

Future<void> adding(String name, String age) async {
  await profileDB
      .rawInsert('INSERT INTO usu(name,age)VALUES(?,?)', [name, age]);
}

Future<void> updated(String name, String age) async {
  await profileDB.rawUpdate(
      'UPDATE usu SET name = ?,age = ? WHERE name=? AND age = ?', [name, age]);
}

Future<void> read() async {
  await profileDB.query('SELECT * FROM usu');
}

Future<void> delete(String name) async {
  await profileDB.rawDelete('DELETE FROM usu WHERE name = ?', [name]);
}

Future<void> crtdb() async {
  await openDatabase(
    'path',
    version: 1,
    onCreate: (db, version) async =>
        db.execute('CREATE TABLE test (id PRIMARY KEY, name TEXT, age TEXT)'),
  );
}

Future<void> add(String name, String age) async {
  await profileDB
      .rawInsert('INSERT INTO test(name, age)VALUES(?,?)', [name, age]);
}

Future<void> craet() async {
  await openDatabase('CREATE TABLE fouzan(id PRIMARY KEY, name TEXT,age TEXT)');
}
