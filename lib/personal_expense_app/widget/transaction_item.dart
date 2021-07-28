import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.currentTx,
    required this.theme,
    required this.mediaQuery,
    required this.callBack,
  }) : super(key: key);

  final Transaction currentTx;
  final ThemeData theme;
  final MediaQueryData mediaQuery;
  final Function callBack;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const List<Color> bgColorList = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.blue,
    ];

    _bgColor = bgColorList[Random().nextInt(bgColorList.length)];

    super.initState();
  }

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
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.currentTx.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.currentTx.title,
          style: widget.theme.textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget.currentTx.date),
        ),
        trailing: widget.mediaQuery.size.width > 460
            ? TextButton.icon(
                onPressed: () => widget.callBack(widget.currentTx),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                style: TextButton.styleFrom(
                  primary: widget.theme.errorColor,
                  //backgroundColor: Colors.amber,
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => widget.callBack(widget.currentTx),
                color: widget.theme.errorColor,
              ),
      ),
    );
  }
}
