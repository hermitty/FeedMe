import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final textEditingController;
  final labelText;

  InputField(this.textEditingController, this.labelText);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new TextFormField(
          //enabled: false,
          maxLines: null,
          controller: widget.textEditingController,
          decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(fontSize: 18.0)),
          keyboardType: TextInputType.multiline,
        ),
        margin: EdgeInsets.only(bottom: 15.0));
  }
}
