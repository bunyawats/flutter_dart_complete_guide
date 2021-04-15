import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.currentTx,
    @required this.theme,
    @required this.mediaQuery,
    @required this.callBack,
  }) : super(key: key);

  final Transaction currentTx;
  final ThemeData theme;
  final MediaQueryData mediaQuery;
  final Function callBack;

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => callBack(currentTx),
                color: theme.errorColor,
              ),
      ),
    );
  }
}
