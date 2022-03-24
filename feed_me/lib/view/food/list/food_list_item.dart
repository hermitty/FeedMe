import 'package:feed_me/model/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';

class FoodListItem extends StatefulWidget {
  final Food food;

  FoodListItem(this.food);

  @override
  _FoodListItemState createState() => _FoodListItemState(this.food.id);
}

class _FoodListItemState extends State<FoodListItem> {
  final Guid foodId;
  Widget icon;
  bool favourite;

  _FoodListItemState(this.foodId) {
    setFavouriteIcon(false);
  }

  void setFavourite(bool favourite) {
    setState(() {
      setFavouriteIcon(favourite);
    });
    this.favourite = favourite;
  }

  void setFavouriteIcon(bool favourite) {
    icon = Icon(favourite ? Icons.favorite : Icons.favorite_border);
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
            child: widget.food.image == null || widget.food.image.isEmpty
                ? Image(
                    image: AssetImage('assets/empty-image.png'),
                    fit: BoxFit.cover)
                : Image.network(
                    widget.food.image,
                    fit: BoxFit.cover,
                  )),
        footer: GridTileBar(
          backgroundColor: new Color.fromRGBO(32, 32, 32, 0.7),
          title: Text(
            widget.food.name ?? "",
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: icon,
            color: Theme.of(context).accentColor,
            onPressed: () {
              setFavourite(!favourite);
            },
          ),
        ),
      ),
    );
  }
}
