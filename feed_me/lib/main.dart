import 'package:feed_me/view/food/list/food_list.dart';
import 'package:feed_me/view/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'injector/injector.dart';

void main() {
  setup();
  runApp(FeedMeApp());
}

class FeedMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    drawer: SideMenu(), 
    body: FoodList());
  }
}