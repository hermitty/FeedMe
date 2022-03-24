import 'package:feed_me/client/api_client.dart';
import 'package:feed_me/injector/injector.dart';
import 'package:feed_me/model/food.dart';

class FoodService {
  final _api = injector.get<ApiClient>();

  Future addFood(FoodToSave food) async {
    _api.addFood(food);
  }

  Future<List<Food>> getFood(
      int page, String searchText, List<String> selectedTags) async {
    return await _api.getFood(page, searchText, selectedTags);
  }
}
