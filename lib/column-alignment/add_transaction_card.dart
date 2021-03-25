import 'package:flutter/material.dart';

class AddTransactionCard extends StatelessWidget {
  const AddTransactionCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String titleInput;
    String amountInput;

    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (val) => titleInput = val,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              onChanged: (val) => amountInput = val,
            ),
            TextButton(
              onPressed: () {
                print('titleInput : ${titleInput}');
                print('amountInput : ${amountInput}');
              },
              child: Text('Add Transaction'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
