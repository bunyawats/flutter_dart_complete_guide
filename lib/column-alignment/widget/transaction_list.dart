import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction_card.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function callBack;

  const TransactionList({
    Key key,
    this.transactions,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: theme.textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraint.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              var currentTx = transactions[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${currentTx.amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    currentTx.title,
                    style: theme.textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(currentTx.date),
                  ),
                  trailing: mediaQuery.size.width > 460
                      ? TextButton.icon(
                          onPressed: () => callBack(currentTx),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          style: TextButton.styleFrom(
                              primary: theme.errorColor,
                              //backgroundColor: Colors.amber,
                              textStyle: TextStyle(
                                  fontSize: 24, fontStyle: FontStyle.italic)))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => callBack(currentTx),
                          color: theme.errorColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
