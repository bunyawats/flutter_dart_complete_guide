import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final Function callBack;

  const TextControl({Key key, this.callBack}) : super(key: key);

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
