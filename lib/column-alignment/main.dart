import 'package:flutter/material.dart';
import './transaction.dart';
import './transaction_card.dart';
import './add_transaction_card.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final title = 'Column Alignment';

  final List<Transaction> transactions = transactionList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
              AddTransactionCard(),
              Column(
                children: transactions
                    .map((tx) => TransactionCard(
                          transaction: tx,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
