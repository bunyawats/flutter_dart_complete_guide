import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final _questionList = const [
    {
      'questionText': 'What \'s your favorite color?',
      'answers': ['Black', 'Red', 'Green', 'White'],
    },
    {
      'questionText': 'What \'s your favorite animal?',
      'answers': ['Rabbit', 'Snake', 'Elephant', 'Lion'],
    },
    {
      'questionText': 'What \'s your favorite instructor?',
      'answers': ['Max', 'Max', 'Max', 'Max'],
    },
  ];

  var _index = 0;

  void _answerAction() {
    if (_index < _questionList.length) {
      print('We have more questions');
    }

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
        body: (_index < _questionList.length)
            ? Column(
                children: <Widget>[
                  Question(
                    _questionList.elementAt(_index)['questionText'],
                  ),
                  ...(_questionList.elementAt(_index)['answers']
                          as List<String>)
                      .map((_answer) {
                    return Answer(
                      answer: _answer,
                      callback: _answerAction,
                    );
                  }).toList(),
                ],
              )
            : Center(
                child: Text('You did it'),
              ),
      ),
    );
  }
}
