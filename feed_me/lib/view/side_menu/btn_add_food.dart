import 'package:flutter/material.dart';

class AddFoodBtn extends StatelessWidget {
  const AddFoodBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.food_bank),
      title: Text('Add food'),
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return null;
        }))
      },
    );
  }
}