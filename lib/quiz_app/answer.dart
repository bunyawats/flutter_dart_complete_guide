import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final Function callback;

  Answer({this.answer, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Text(
          this.answer,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: this.callback,
      ),
    );
  }
}
