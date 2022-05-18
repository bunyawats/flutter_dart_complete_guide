import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final VoidCallback callBack;

  TextControl({super.key, required this.callBack});

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
