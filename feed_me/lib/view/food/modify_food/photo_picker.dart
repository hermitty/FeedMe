import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class PhotoPicker extends StatefulWidget {
  File _image;

  PhotoPicker(this._image);

  @override
  _PhotoPickerState createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  Future getImage() async {
    var imagePicker = new ImagePicker();
    var pickedImage = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      widget._image = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        CircleAvatar(
          radius: 100,
          backgroundColor: Color(0xff476cfb),
          child: ClipOval(
            child: new SizedBox(
                width: 180.0,
                height: 180.0,
                child: (widget._image != null)
                    ? Image.file(
                        widget._image,
                        fit: BoxFit.fill,
                      )
                    : Image(
                        image: AssetImage('assets/empty-image.png'),
                        fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: IconButton(
            icon: Icon(
              Icons.camera_alt,
              size: 50.0,
            ),
            onPressed: getImage,
          ),
        ),
      ],
    ));
  }
}
