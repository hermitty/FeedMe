import 'package:flutter_tagging/flutter_tagging.dart';

class Tag extends Taggable {
  int id = 0;
  String name;
  int popularity = 0;

  Tag(this.name);
  Tag.existing(this.id, this.name, this.popularity);

  @override
  List<Object> get props => [name];
}