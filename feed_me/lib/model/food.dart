//TODO
//readonly  favourite not to save
//image file
//
import 'package:feed_me/model/tag.dart';

class FoodDetails {
  int id;
  String name;
  String image;
  String description;
  bool favourite;
  String link;
  List<Tag> tags;

  FoodDetails();

  FoodDetails.map(dynamic obj) {
    this.id = obj["id"];
    this.name = obj["name"];
    this.description = obj["description"];
    this.image = obj["image"];
    this.favourite = obj["favourite"] == 1 ? true : false;
    this.link = obj["link"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["image"] = image;
    map["favourite"] = favourite;
    return map;
  }
}

class FoodSimple {
  int id;
  String name;
  String image;
  bool favourite;

  FoodSimple(this.id, this.name, this.image, this.favourite);

    FoodSimple.map(dynamic obj) {
    this.id = obj["id"];
    this.name = obj["name"];
    this.image = obj["image"];
    this.favourite = obj["favourite"] == 1 ? true : false;
  }
}
