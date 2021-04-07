import 'package:flutter/material.dart';

import 'btn_add_food.dart';
import 'btn_manage_tag.dart';
import 'header_side_menu.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SideMenuHeader(),
          AddFoodBtn(),
          AddTagBtn(),
        ],
      ),
    );
  }
}





