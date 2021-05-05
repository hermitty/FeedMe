import 'package:flutter_tagging/flutter_tagging.dart';

//TODO 2 objects
// popularity not inportant

// ignore: must_be_immutable
class Tag extends Taggable {
  int id = 0;
  String name;
  int popularity = 0;

  Tag(this.name);
  Tag.existing(this.id, this.name, this.popularity);

  @override
  List<Object> get props => [name];

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["popularity"] = popularity;
    return map;
  }
}
