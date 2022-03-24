import 'dart:io';
import 'package:flutter_guid/flutter_guid.dart';

class Food {
  Guid id;
  String name;
  String image;
  String description;
  List<String> tags;

  Food(this.name, this.description, this.image, this.tags);

  String tagsToString() {
    if (tags == null || tags.length == 0) return '';
    return tags.join(', ');
  }

  Food.map(dynamic obj) {
    this.id = new Guid(obj["id"]);
    this.name = obj["name"];
    this.description = obj["description"];
    this.tags = (obj["tags"] as List).map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["name"] = name;
    map["description"] = description;
    map["image"] = image;

    return map;
  }
}

class FoodToSave {
  Guid id;
  String name;
  File image;
  String description;
  List<String> tags;
}
