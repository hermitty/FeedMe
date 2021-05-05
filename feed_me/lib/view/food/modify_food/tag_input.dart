import 'package:feed_me/injector/injector.dart';
import 'package:feed_me/model/tag.dart';
import 'package:feed_me/service/tag_service.dart';
import 'package:feed_me/view/helper/tag_input_field/tag_input_field.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class TagInput extends StatefulWidget {
  List<Tag> selectedTags;
  TagInput(this.selectedTags);

  @override
  _TagInputState createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  final _tagService = injector.get<TagService>();
  List<Tag> suggestionTags = [];
  TagInputField inputField;

  @override
  void initState() {
    super.initState();
    inputField = TagInputField(suggestionTags, widget.selectedTags);
    _tagService.getTags().then((value) => setList(value));
  }

  void setList(List<Tag> list) {
    setState(() {
      suggestionTags.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return inputField;
  }
}
