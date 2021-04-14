import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });

  static final List<Transaction> sampleTransactions = [
    Transaction(
      id: 'tq',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'tq',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'tq',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New Shoe',
      amount: 100,
      date: DateTime.now(),
    ),
  ];
}
