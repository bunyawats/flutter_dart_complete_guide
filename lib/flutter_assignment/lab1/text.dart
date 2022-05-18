import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;

  const MyText({super.key, this.text = 'NA'});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      width: double.infinity,
    );
  }
}
