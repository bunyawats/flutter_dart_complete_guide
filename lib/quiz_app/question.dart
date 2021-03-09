import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String _question;

  Question(this._question);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Text(
        _question,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,

        ),
      ),
    );
  }
}
