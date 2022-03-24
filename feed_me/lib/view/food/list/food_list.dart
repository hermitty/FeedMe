import 'package:feed_me/injector/injector.dart';
import 'package:feed_me/model/food.dart';
import 'package:feed_me/service/food_service.dart';
import 'package:feed_me/view/food/modify_food/tag_input.dart';
import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  final _foodService = injector.get<FoodService>();
  final _textFieldController = TextEditingController();

  int _page = 1;
  String _searchText = '';
  List<String> _selectedTags = [];

  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;

  List<Food> _items = [];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    _foodService
        .getFood(_page, _searchText, _selectedTags)
        .then((value) => setState(() {
              _items = value;
            }));

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;

      final fetchedItems =
          await _foodService.getFood(_page, _searchText, _selectedTags);

      if (fetchedItems.length > 0) {
        setState(() {
          _items.addAll(fetchedItems);
        });
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textField = TextField(
      controller: _textFieldController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by name',
        suffixIcon: IconButton(
          onPressed: clearTextField,
          icon: Icon(Icons.clear),
        ),
      ),
      onChanged: (value) {
        filterByName(value);
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

    final tagInput = TagInput(
      onChanged: (value) {
        var tags = value.map((e) => e.name).toList();
        filterByTags(tags);
      },
      additionEnabled: false,
    );

    return Scaffold(
      body: _isFirstLoadRunning
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
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
                tagInput,
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _items.length,
                    itemBuilder: (_, index) => Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: ListTile(
                        title: Text(_items[index].name ?? ''),
                        subtitle: Text(_items[index].tagsToString()),
                      ),
                    ),
                  ),
                ),

                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    color: Colors.white24,
                    child: Center(
                      child: Text(''),
                    ),
                  ),
              ],
            ),
    );
  }

  filterByName(String textValue) {
    _page = 1;
    _searchText = textValue;
    _firstLoad();
  }

  filterByTags(List<String> tags) {
    _page = 1;
    _selectedTags = tags;
    _firstLoad();
  }

  clearTextField() {
    setState(() {
      _page = 1;
      _textFieldController.clear();
      _searchText = '';
      _firstLoad();
    });
  }
}
