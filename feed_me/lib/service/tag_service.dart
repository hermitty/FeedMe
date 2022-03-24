import 'package:feed_me/client/api_client.dart';
import 'package:feed_me/injector/injector.dart';
import 'package:feed_me/model/tag.dart';

class TagService {
  final _api = injector.get<ApiClient>();

  List<Tag>? tags;

  Future<List<Tag>> refreshTags() async => tags = await _api.getTags();
  
  Future<List<Tag>?> getTags() async {
    if (tags == null) await refreshTags();
    return tags;
  }
}
