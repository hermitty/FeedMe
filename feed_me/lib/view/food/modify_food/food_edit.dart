import 'package:feed_me/injector/injector.dart';
import 'package:feed_me/model/food.dart';
import 'package:feed_me/model/tag.dart';
import 'package:feed_me/service/food_service.dart';
import 'package:feed_me/view/food/modify_food/photo_picker.dart';
import 'package:feed_me/view/food/modify_food/tag_input.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'input_field.dart';

class FoodEdit extends StatefulWidget {
  final food;
  FoodEdit([this.food]);

  @override
  _FoodEditState createState() => _FoodEditState();
}

class _FoodEditState extends State<FoodEdit> {
  File? _image;
  var tagList = <String>[];
  final foodService = injector.get<FoodService>();
  List<Tag> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    var nameController = new TextEditingController(
        text: widget.food != null ? widget.food.name : '');
    var decsriptionController = new TextEditingController(
        text: widget.food != null ? widget.food.description : '');

    var tagInput = TagInput(onChanged: (value) {
      selectedTags = value;
    });

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 30.0, right: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80.0),
              PhotoPicker(_image),
              InputField(nameController, 'name'),
              InputField(decsriptionController, 'description'),
              SizedBox(height: 15),
              tagInput,
              SizedBox(height: 25.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff476cfb),
                  ),
                  onPressed: () {
                    saveFood(nameController, decsriptionController);
                  },
                  child: Text('Save',
                      style: TextStyle(color: Colors.white, fontSize: 16.0))),
            ],
          ),
        ),
      ),
    );
  }

  void saveFood(TextEditingController nameController,
      TextEditingController decsriptionController) {
    FoodToSave food = FoodToSave();
    food.name = nameController.text;
    food.description = decsriptionController.text;
    food.image = _image;
    food.tags = selectedTags.map((e) => e.name).toList();

    foodService.addFood(food);
  }
}
