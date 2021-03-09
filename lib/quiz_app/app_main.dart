import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  var _questionList = [
    'Question 1',
    'Question 2',
    'Question 3',
  ];

  var _index = 0;

  void _answerAction() {
    setState(() {
      _index = _index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: Column(
          children: <Widget>[
            Question(
              _questionList.elementAt(_index % 3),
            ),
            Answer(
              answer: 'Answer 1',
              callback: _answerAction,
            ),
            Answer(
              answer: 'Answer 2',
              callback: _answerAction,
            ),
            Answer(
              answer: 'Answer 3',
              callback: _answerAction,
            ),
          ],
        ),
      ),
    );
  }
}
