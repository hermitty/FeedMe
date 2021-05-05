import 'package:feed_me/model/food.dart';
import 'package:feed_me/model/tag.dart';
import 'package:feed_me/service/db_service.dart';

class FoodService {
final _db = new DatabaseHelper();

//TODO map to db model
  Future addFood(FoodDetails food) async => _db.saveFood(food);
  Future editFood(FoodDetails food) async => _db.updateFood(food);
  Future deleteFood(int foodId) async => _db.deleteFood(foodId);
  //TODO set popularity
  Future<FoodDetails> getFoodById(int id) async => _db.getFoodById(id);
  Future<List<FoodSimple>> getFoodByTags(List<Tag> tags) async { return <FoodSimple>[]; }
  Future<List<FoodSimple>> getFoodSimpleList() async => _db.getFoodSimpleList();
  Future setFavouriteForFood(int foodId, bool value) async {}
}
