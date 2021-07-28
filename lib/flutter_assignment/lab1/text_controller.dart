import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final VoidCallback callBack;

  TextControl({Key? key, required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text('Change Text'),
        onPressed: callBack,
      ),
    );
  }
}
