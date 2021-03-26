import 'package:flutter/material.dart';
import 'model/transaction.dart';
import 'widget/new_transaction.dart';
import 'widget/transaction_list.dart';

void main() => runApp(MyApp());

final title = 'Column Alignment';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
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

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactionCard(
            callBack: _addNewTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            TransactionList(
              transactions: _userTransactions,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
