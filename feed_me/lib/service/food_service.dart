import 'package:feed_me/model/food.dart';
import 'package:feed_me/model/tag.dart';

List<FoodSimple> simpleFood = [
  FoodSimple("food1", "https://hermitty.blob.core.windows.net/images/cb4e3564-46ae-42fc-8a2c-e160a6d4a346.jpeg", false),
  FoodSimple("food1", "https://hermitty.blob.core.windows.net/images/cb4e3564-46ae-42fc-8a2c-e160a6d4a346.jpeg", false),
  FoodSimple("food1", "https://hermitty.blob.core.windows.net/images/cb4e3564-46ae-42fc-8a2c-e160a6d4a346.jpeg", false),
  ];

class FoodService {
  Future addFood(Food food) async {}
  Future editFood(Food food) async {}
  Future deleteFood(int foodId) async {}
  Future<Food> getFoodById(int id) async { return Food();}
  Future<List<FoodSimple>> getFoodByTags(List<Tag> tags) async { return <FoodSimple>[]; }
  Future<List<FoodSimple>> getFood() async { return simpleFood; }
  Future setFvouriteForFood(int foodId, bool value) async {}
}