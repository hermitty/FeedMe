
import 'package:flutter/material.dart';

class AddTagBtn extends StatelessWidget {
  const AddTagBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.tag),
      title: Text('Manage tag'),
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return null;
        } as Widget Function(BuildContext)))
      },
    );
  }
}