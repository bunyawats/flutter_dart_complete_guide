import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      //   maxWidth: 600,
    );

    if (pickedImageFile == null) {
      return;
    }

    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              (_pickedImage != null) ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
