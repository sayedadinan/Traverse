import 'package:sqflite/sqflite.dart';

late Database db;
Future<void> initproperties() async {
  db = await openDatabase(
    'propertiestrip',
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE companions (id INTEGER PRIMARY KEY, name TEXT, number TEXT, tripID INTEGER)');
    },
  );
}

addCompanions(Map<String, dynamic> companion) async {
  db.insert('companions', companion);
}
