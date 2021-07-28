import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final Function answerQuestion;
  final List questionList;
  final int index;

  Quiz({
    required this.questionList,
    required this.index,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Question(
            questionList[index]['questionText'],
          ),
          ...(questionList[index]['answers'] as List<Map<String, Object>>)
              .map((_answer) {
            return Answer(
              answer: _answer['text'] as String,
              callback: () => answerQuestion(_answer['score']),
            );
          }).toList(),
        ],
      ),
    );
  }
}
