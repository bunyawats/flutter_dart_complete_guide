import 'package:flutter/material.dart';

import '../model/transaction.dart';
import 'transaction_item.dart';

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
        // : ListView.builder(
        //     itemBuilder: (ctx, index) {
        //       var currentTx = transactions[index];
        //
        //       return TransactionItem(
        //         key: ValueKey(currentTx.id),
        //         currentTx: currentTx,
        //         theme: theme,
        //         mediaQuery: mediaQuery,
        //         callBack: callBack,
        //       );
        //     },
        //     itemCount: transactions.length,
        //   );
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      currentTx: tx,
                      theme: theme,
                      mediaQuery: mediaQuery,
                      callBack: callBack,
                    ))
                .toList(),
          );
  }
}
