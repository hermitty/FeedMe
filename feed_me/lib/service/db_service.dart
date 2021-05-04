import 'package:feed_me/model/food.dart';
import 'package:feed_me/model/tag.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE FoodModel(id INTEGER PRIMARY KEY, name TEXT, description TEXT, image TEXT, favourite INTEGER DEFAULT 0 NOT NULL)");
  }

  Future<int> saveFoodModel(FoodModel food) async {
    var dbClient = await db;
    int res = await dbClient.insert("FoodModel", food.toMap());
    return res;
  }

  Future<List<FoodModel>> getFoodModel() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM FoodModel');
    List<FoodModel> employees = [];
    for (int i = 0; i < list.length; i++) {
      var food =
          new FoodModel(list[i]["name"], list[i]["description"], list[i]["image"], list[i]["favourite"]);
      food.setFoodModelId(list[i]["id"]);
      employees.add(food);
    }
    print(employees.length);
    return employees;
  }

   Future<List<FoodSimple>> getFoodSimple() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM FoodModel');
    List<FoodSimple> FoodList = [];
    for (int i = 0; i < list.length; i++) {
      var food =
          new FoodSimple(list[i]["id"], list[i]["name"], list[i]["image"], list[i]["favourite"] == 1 ? true : false);
      FoodList.add(food);
    }
    return FoodList;
  }

  Future<int> deleteFoodModels(FoodModel food) async {
    var dbClient = await db;

    int res =
        await dbClient.rawDelete('DELETE FROM Food WHERE id = ?', [food.id]);
    return res;
  }

  Future<bool> update(FoodModel food) async {
    var dbClient = await db;




    int res =   await dbClient.update("Food", food.toMap(),
        where: "id = ?", whereArgs: <int>[food.id]);



    return res > 0 ? true : false;
  }

  Future<List<Tag>> getTags() async {
    return [
      Tag('test1'),
      Tag('test2')
    ].toList();
  }
}