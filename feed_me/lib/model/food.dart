import 'dart:io';

class FoodSimple {
  int id;
  String name;
  String image;
  bool favourite;

  FoodSimple(this.name, this.image, this.favourite);
}

class FoodToSave {
  int id;
  String name;
  File image;
  String description;
  List<String> tags;
}
