import 'package:restoran_app/commons/database.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  final String tb_name='resto';
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();
  factory DBHelper()=> _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await initializeDatabase();
    return _database;
  }

  Future <List<Restaurant>> get() async{
    var db = await _db;
    List<Map<String, dynamic>> result = await db!.query(tb_name);
    List<Restaurant> restaurantLists = [];

    for (Map<String, dynamic> row in result) {
      restaurantLists.add(
          Restaurant(
              id: row['id'],
              name: row['name'],
              pictureId: row['pictureId'],
              city: row['city'],
              rating: row['rating']
          )
      );
    }

    return restaurantLists;
  }

  Future <List<Restaurant>> getById(String id) async {
    var db = await _db;
    List<Map<String, dynamic>>  result = await db!.query(tb_name, where: 'id = ?', whereArgs: [id]);
    List<Restaurant> restaurantLists = [];

    for (Map<String, dynamic> row in result) {
      restaurantLists.add(
          Restaurant(
              id: row['id'],
              name: row['name'],
              pictureId: row['pictureId'],
              city: row['city'],
              rating: row['rating']
          )
      );
    }

    return restaurantLists;
  }

  Future<int> insert(Restaurant restaurant) async {
    var db = await _db;
    var result = await db!.insert(tb_name, restaurant.toMap());
    return result;
  }


  Future<int> delete(String id) async {
    var db = await _db;
    int result = await db!.delete(tb_name, where: 'id = ?', whereArgs: [id]);
    return result;
  }
}