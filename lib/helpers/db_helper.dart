import 'dart:developer';

import 'package:flutter_app_eb/models/restaurant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DbHelper {
  final int version = 1;
  Database db;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'reviews.db'),
          onCreate: (db, version) {
            db.execute(
                'CREATE TABLE review(id TEXT PRIMARY KEY, name TEXT, review TEXT , city TEXT)');
          }, version: version);
    }
    return db;
  }

  Future<int> insertReview(Restaurant restaurant) async {
    print(restaurant.toMap());
    int id = await db.insert('review', restaurant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
  Future<int> deleteReview(Restaurant restaurant) async {
    print("ENTRA");
    print(restaurant);
    int result =
    await db.delete('review', where: 'id = ?', whereArgs: [restaurant.id]);
    return result;
  }

  Future<dynamic>getAllReviews () async {
    List<Map<String,dynamic>> reviews= await db.rawQuery('SELECT * FROM review');

    return reviews;

  }



}