import 'dart:io';

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
    File(path).delete();
    var theDb = await openDatabase(path, version: 2, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE Food(id INTEGER PRIMARY KEY, name TEXT, description TEXT, image TEXT, favourite INTEGER DEFAULT 0, link TEXT)");
    await db.execute("CREATE TABLE Tag(id INTEGER PRIMARY KEY, name TEXT, popularity INTEGER)");
    await db.execute("CREATE TABLE FoodTagLink(foodId INTEGER, tagId INTEGER, FOREIGN KEY (foodId) REFERENCES Food (id) ON DELETE CASCADE ON UPDATE NO ACTION, FOREIGN KEY (tagId) REFERENCES Tag (id) ON DELETE CASCADE ON UPDATE NO ACTION)");
  }

//TODO save tags
  Future<int> saveFood(FoodDetails food) async {
    var dbClient = await db;
    int foodId = await dbClient.insert("Food", food.toMap());
    await _saveTagsForFood(food.tags, foodId);
    return foodId;
  }

  //TODO different model for tags
  Future _saveTagsForFood(List<Tag> tags, int foodId) async {
    var dbClient = await db;
    for (int i = 0; i < tags.length; i++) {
      var tag = tags[i];
      if (tag.id == 0) {
        tag.id = await dbClient.insert("Tag", tag.toMap());
      }
      else{
        tag.popularity = tag.popularity+1;
        await dbClient.update("Tag", tag.toMap());
      }
      var map = new Map<String, dynamic>();
      map["foodId"] = foodId;
      map["tagId"] = tag.id;
      await dbClient.insert("FoodTagLink", map);
    }
  }

//TODO order by favourite
  Future<List<FoodSimple>> getFoodSimpleList() async {
    var dbClient = await db;
    List<Map> queryResult = await dbClient.rawQuery('SELECT * FROM Food');
    List<FoodSimple> foodList = [];
    for (int i = 0; i < queryResult.length; i++) {
      var food = FoodSimple.map(queryResult[i]);
      foodList.add(food);
    }
    return foodList;
  }

  //TODO order by favourite
  Future<List<FoodSimple>> getFoodByTags() async {
    var dbClient = await db;
    List<Map> queryResult = await dbClient.rawQuery(
        'SELECT * FROM Food f inner join FoodTagLink ftl on f.id = ftl.foodId where ftl.tagId in (?)');
    var foodList = [];
    for (int i = 0; i < queryResult.length; i++) {
      var food = FoodSimple.map(queryResult[i]);
      foodList.add(food);
    }
    return foodList;
  }

  Future<FoodDetails> getFoodById(int id) async {
    var dbClient = await db;
    List<Map> queryResult =
        await dbClient.rawQuery('SELECT TOP(1) * FROM Food');
    var food = FoodDetails.map(queryResult[0]);
    return food;
  }

//TODO delete tags
  Future<int> deleteFood(int foodId) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete('DELETE FROM Food WHERE id = ?', [foodId]);
    return res;
  }

//TODO update tags
  Future<bool> updateFood(FoodDetails food) async {
    var dbClient = await db;
    int res = await dbClient.update("Food", food.toMap(),
        where: "id = ?", whereArgs: <int>[food.id]);

    return res > 0 ? true : false;
  }

  Future<List<Tag>> getTags() async {
    return [Tag('test1'), Tag('test2')].toList();
  }
}
