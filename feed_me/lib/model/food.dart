import 'dart:io';

class FoodSimple {
  int id;
  String name;
  String image;
  bool favourite;

  FoodSimple(this.id, this.name, this.image, this.favourite);
}

class FoodToSave {
  int id;
  String name;
  File image;
  String description;
  List<String> tags;
}

class FoodModel {
  int id;
  String name;
  String image;
  String description;
  bool favourite;


  FoodModel(this.name, this.description, this.image, this. favourite);

  FoodModel.map(dynamic obj) {
    this.name = obj["name"];
    this.description = obj["description"];
    this.image = obj["image"];
    this.favourite = obj["favourite"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["name"] = name;
    map["description"] = description;
    map["image"] = image;
    map["favourite"] = favourite;

    return map;
  }

  void setFoodModelId(int id) {
    this.id = id;
  }
}
