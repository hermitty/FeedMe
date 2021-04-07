import 'package:feed_me/model/food.dart';
import 'package:flutter/material.dart';

class FoodListItem extends StatelessWidget {
  final FoodSimple food;
  Widget icon;

  FoodListItem(this.food)
  {
    icon = Icon(food.favourite ? Icons.favorite : Icons.favorite_border);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return null;
            }));
          },
          child: Image.network(
            food.image,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: new Color.fromRGBO(32, 32, 32, 0.7),
          title: Text(
            food.name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: icon,
            color: Theme.of(context).accentColor,
            onPressed: () {
              icon = Icon(Icons.favorite);
            },
          ),
        ),
      ),
    );
  }
}
