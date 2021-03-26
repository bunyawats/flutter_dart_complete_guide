import 'package:flutter/material.dart';
import './widget/transaction_list.dart';
import 'widget/new_transaction.dart';
import 'widget/user_transaction.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final title = 'Column Alignment';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                child: Text(
                  'Card 1',
                  textAlign: TextAlign.center,
                ),
                color: Colors.green,
                margin: EdgeInsets.all(10),
                elevation: 5,
              ),
            ),
            UserTransaction(),
          ],
        ),
      ),
    );
  }
}
