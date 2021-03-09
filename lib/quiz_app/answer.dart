import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final Function callback;

  Answer({this.answer, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: RaisedButton(
        child: Text(this.answer),
        color: Colors.blue,
        onPressed: this.callback,
      ),
      
    );
  }
}
