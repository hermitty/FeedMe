import 'package:feed_me/model/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

// ignore: must_be_immutable
class TagInputField extends StatefulWidget {
  List<Tag> selectedTags;
  List<Tag> suggestionTags;

  TagInputField(this.suggestionTags, this.selectedTags);

  @override
  _TagInputFieldState createState() => _TagInputFieldState();
}

class _TagInputFieldState extends State<TagInputField> {
  @override
  Widget build(BuildContext context) {
    return FlutterTagging<Tag>(
        suggestionsBoxConfiguration:
            SuggestionsBoxConfiguration(autoFlipDirection: true),
        initialItems: widget.selectedTags,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.blue.withAlpha(30),
            hintText: 'Search Tags',
            labelText: 'Select Tags',
          ),
        ),
        findSuggestions: getSuggestedTags,
        additionCallback: (value) {
          return Tag(value);
        },
        onAdded: (tag) {
          return tag;
        },
        configureSuggestion: (tag) {
          return SuggestionConfiguration(
            title: Text(tag.name),
            additionWidget: Chip(
              avatar: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              label: Text('Add New Tag'),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
              ),
              backgroundColor: Colors.blue,
            ),
          );
        },
        configureChip: (tag) {
          return ChipConfiguration(
            label: Text(tag.name),
            backgroundColor: Colors.blue,
            labelStyle: TextStyle(color: Colors.white),
            deleteIconColor: Colors.white,
          );
        },
        onChanged: () {});
  }

  Future<List<Tag>> getSuggestedTags(String query) async {
    await Future.delayed(Duration(milliseconds: 200), null);
    return widget.suggestionTags
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
