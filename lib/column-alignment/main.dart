import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget/chart.dart';
import 'model/transaction.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
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
  final List<Transaction> _userTransactions = [
    //   Transaction(
    //     id: 'tq',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't2',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't3',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 'tq',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't2',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't3',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 'tq',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't2',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't3',
    //     title: 'New Shoe',
    //     amount: 100,
    //     date: DateTime.now(),
    //   ),
  ];

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
    String txTitle,
    double txAmount,
    DateTime txDate,
  }) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
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
    var appBar = AppBar(
      title: Text('Personal Expense'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    double _availableHeight(double pctHeight) {
      return (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          pctHeight;
    }

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Short Chart'),
                Switch(
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
                    height: _availableHeight(0.9),
                    child: Chart(
                      recentTransactions: _recentTransactions,
                    ),
                  )
                : Container(
                    height: _availableHeight(0.7),
                    child: TransactionList(
                      transactions: _userTransactions,
                      callBack: _removeTransaction,
                    ),
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
