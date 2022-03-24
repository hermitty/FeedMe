import 'dart:convert';
import 'package:feed_me/model/food.dart';
import 'package:feed_me/model/tag.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final _baseUrl = 'https://e853-193-19-165-236.ngrok.io';

  Future<List<Tag>> getTags() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/Tag'));
      final result = json.decode(response.body);
      final tags = (result as List).map((e) => Tag(e.toString())).toList();
      return tags;
    } catch (err) {
      print('Something went wrong');
    }
    return [];
  }

  Future addFood(FoodToSave food) async {}

  Future<List<Food>> getFood(
      int page, String searchText, List<String> selectedTags) async {
    try {
      Map<String, String> queryParams = {'Page': page.toString(), 'Size': '15'};

      if (searchText != null && searchText != '') {
        queryParams.addAll({'Name': searchText});
      }

      if (selectedTags != null && selectedTags.length != 0) {
        selectedTags.forEach((element) {
          queryParams.addAll({'Tags': element});
        });
      }
      var uri = Uri.parse("$_baseUrl/Recipe/search")
          .replace(queryParameters: queryParams);
      final response = await http.get(uri);
      final result = json.decode(response.body);
      final food =
          (result['elements'] as List).map((e) => Food.map(e)).toList();
      return food;
    } catch (err) {
      print('Something went wrong');
    }
    return [];
  }
}
