// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text

import 'package:flutter/material.dart';

import './text.dart';
import './text_controller.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var myText = 'My Text';

  void chageText() {
    setState(() {
      myText = 'New Text';
    });
    print('on pressed -- ');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 1',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assignment 1'),
        ),
        body: Column(
          children: <Widget>[
            MyText(text: myText),
            TextControl(
              callBack: chageText,
            ),
          ],
        ),
      ),
    );
  }
}
