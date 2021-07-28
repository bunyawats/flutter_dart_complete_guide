import 'package:flutter/cupertino.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  static final List<Transaction> sampleTransactions = [
    Transaction(
      id: '100',
      title: 'New Shoe 1',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '101',
      title: 'New Shoe 2',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '102',
      title: 'New Shoe 3',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '103',
      title: 'New Shoe 4',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '104',
      title: 'New Shoe 5',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '105',
      title: 'New Shoe 6',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '106',
      title: 'New Shoe 7',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '107',
      title: 'New Shoe 8',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '108',
      title: 'New Shoe 9',
      amount: 100,
      date: DateTime.now(),
    ),
  ];
}
