import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;

  const MyText({Key? key, this.text = 'NA'}) : super(key: key);

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
