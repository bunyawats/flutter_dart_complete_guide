import 'package:flutter/material.dart';
import './transaction_card.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return TransactionCard(
            transaction: transactions[index],
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
