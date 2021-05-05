import 'package:feed_me/injector/injector.dart';
import 'package:feed_me/model/food.dart';
import 'package:feed_me/service/food_service.dart';
import 'package:feed_me/view/helper/debouncer.dart';
import 'package:flutter/material.dart';
import 'food_list_item.dart';

class FoodList extends StatefulWidget {
  FoodList() : super();

  @override
  FoodListState createState() => FoodListState();
}

class FoodListState extends State<FoodList> {
  final _foodService = injector.get<FoodService>();
  final _debouncer = Debouncer(milliseconds: 300);
  final textFieldController = TextEditingController();

  List<FoodSimple> food = [];
  List<FoodSimple> filteredFood = [];

  @override
  void initState() {
    super.initState();

    _foodService.getFoodSimpleList().then((value) => setList(value));
  }

  void setList(List<FoodSimple> list) {
    setState(() {
      food = list;
      filteredFood = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textField = TextField(
      controller: textFieldController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by name',
        suffixIcon: IconButton(
          onPressed: clearTextField,
          icon: Icon(Icons.clear),
        ),
      ),
      onChanged: (value) {
        filerListValues(value);
      },
    );
    final filterField = Row(
      children: [
        SizedBox(height: 50),
        Expanded(
          child: textField,
        ),
      ],
    );

    final itemList = GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: filteredFood.length,
      itemBuilder: (ctx, i) => FoodListItem(filteredFood[i]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Row(
            children: [
              IconButton(
            icon: new Icon(Icons.menu_sharp),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
              Expanded(child: filterField),
            ],
          ),
          Expanded(child: itemList),
        ],
      ),
    );
  }

  filerListValues(String textValue) {
    _debouncer.run(() {
      setState(() {
        filteredFood = food
            .where(
                (u) => (u.name.toLowerCase().contains(textValue.toLowerCase())))
            .toList();
      });
    });
  }

  void clearTextField() {
    setState(() {
      textFieldController.clear();
      filteredFood = food;
    });
  }
}
