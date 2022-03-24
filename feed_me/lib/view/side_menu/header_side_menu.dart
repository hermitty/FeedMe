import 'package:flutter/material.dart';

class SideMenuHeader extends StatelessWidget {
  const SideMenuHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.fromLTRB(30, 30, 16, 15),
      child: Text(
        'Feed me',
        style: TextStyle(
          color: Colors.white,
          fontSize: 45,
        ),
      ),
    );
  }
}