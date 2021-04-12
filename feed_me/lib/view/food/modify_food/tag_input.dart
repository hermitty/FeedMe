import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:textfield_tags/textfield_tags.dart';

// ignore: must_be_immutable
class TagInput extends StatefulWidget {
  List<String> tagList;

  TagInput([this.tagList]) {
    if (this.tagList == null) this.tagList = <String>[];
  }

  @override
  _TagInputState createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
        tagsStyler: TagsStyler(
            tagTextStyle: TextStyle(fontWeight: FontWeight.bold),
            tagDecoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            tagCancelIcon:
                Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
            tagPadding: const EdgeInsets.all(6.0)),
        textFieldStyler: TextFieldStyler(
            textFieldBorder: UnderlineInputBorder(),
            hintText: "tags",
            helperText: null,
            helperStyle: TextStyle(fontSize: 18.0)),
        onTag: (tag) {
          if (!widget.tagList.any((element) => element == tag))
            widget.tagList.add(tag);
        },
        onDelete: (tag) {
          widget.tagList.removeWhere((element) => element == tag);
        });
  }
}
