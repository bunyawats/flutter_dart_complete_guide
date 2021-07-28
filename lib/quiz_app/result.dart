import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetQuiz;

  const Result({
    Key? key,
    required this.resultScore,
    required this.resetQuiz,
  }) : super(key: key);

  String get resultPhase {
    String resultText;
    if (resultScore <= 8) {
      resultText = 'You are awesome and innocent';
    } else if (resultScore <= 12) {
      resultText = 'Pretty likeable';
    } else if (resultScore <= 16) {
      resultText = 'You are ... strange?!';
    } else {
      resultText = 'You are so bad!';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                resultPhase,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: resetQuiz,
              child: Text('Restart Quiz'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
