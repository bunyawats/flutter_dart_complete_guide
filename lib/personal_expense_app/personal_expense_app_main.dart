import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';
import 'widget/chart.dart';
import 'widget/new_transaction.dart';
import 'widget/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

final title = 'Column Alignment';

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(
    primarySwatch: Colors.green,
    errorColor: Colors.red,
    fontFamily: 'Quicksand',
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
    appBarTheme: AppBarTheme(
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = Transaction.sampleTransactions;

  bool _showChart = false;

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

  void _addNewTransaction({
    required String txTitle,
    required double txAmount,
    required DateTime txDate,
  }) {
    final newTx = Transaction(
      id: '${DateTime.now()}',
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() => _userTransactions.add(newTx));
  }

  void _removeTransaction(Transaction tx) {
    setState(() => _userTransactions.remove(tx));
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((tx) => tx.date.isAfter(DateTime.now().subtract(
              Duration(
                days: 7,
              ),
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final _isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAdaptiveAppBar(
      context,
      'Personal Expense',
    ) as PreferredSizeWidget;

    final _availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    var pageBody = SafeArea(
      child: SingleChildScrollView(
        child: _isLandscape
            ? _buildLandscape(_availableHeight, theme)
            : _buildPortrait(_availableHeight),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    child: Icon(
                      Icons.add,
                    ),
                    onPressed: () => _startAddNewTransaction(context),
                  )
                : null,
          );
  }

  Widget _buildAdaptiveAppBar(BuildContext context, String title) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
  }

  Column _buildLandscape(double availableHeight, ThemeData theme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Short Chart',
              style: theme.textTheme.headline6,
            ),
            Switch.adaptive(
              activeColor: Theme.of(context).colorScheme.secondary,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              },
            ),
          ],
        ),
        _showChart
            ? Container(
                height: availableHeight * 0.9,
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              )
            : Container(
                height: availableHeight * 0.9,
                child: TransactionList(
                  transactions: _userTransactions,
                  callBack: _removeTransaction,
                ),
              ),
      ],
    );
  }

  Column _buildPortrait(double availableHeight) {
    return Column(
      children: [
        Container(
          height: availableHeight * 0.3,
          child: Chart(
            recentTransactions: _recentTransactions,
          ),
        ),
        Container(
          height: availableHeight * 0.7,
          child: TransactionList(
            transactions: _userTransactions,
            callBack: _removeTransaction,
          ),
        ),
      ],
    );
  }
}
