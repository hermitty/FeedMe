import 'package:feed_me/model/tag.dart';
import 'db_service.dart';

class TagService {
final _db = new DatabaseHelper();

  Future<List<Tag>> getTags() async => await _db.getTags();
}