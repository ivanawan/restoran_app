import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


Future<Database> initializeDatabase() async {
  final database = openDatabase(
      join(await getDatabasesPath(), 'resto_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS resto('
              'id TEXT,'
              'name TEXT,'
              'city TEXT,'
              'rating REAL,'
              'pictureId TEXT'
              ')',
        );
      },
      version: 1);
  return database;
}
