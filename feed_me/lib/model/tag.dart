import 'package:flutter_tagging/flutter_tagging.dart';

class Tag extends Taggable {
  final String name;

  Tag(this.name);
  Tag.existing(this.name);

  @override
  List<Object> get props => [name];
}