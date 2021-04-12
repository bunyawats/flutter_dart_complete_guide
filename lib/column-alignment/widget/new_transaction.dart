import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransactionCard extends StatefulWidget {
  final Function callBack;

  NewTransactionCard({Key key, this.callBack}) : super(key: key);

  @override
  _NewTransactionCardState createState() => _NewTransactionCardState();
}

class _NewTransactionCardState extends State<NewTransactionCard> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    print('titleInput : $enterTitle');
    print('amountInput : $enterAmount');

    if (enterTitle.isEmpty || enterAmount <= 0) {
      return;
    }
    widget.callBack(
      titleController.text,
      double.parse(amountController.text),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[-+.0-9]')),
              ],
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Text('No Date Chosen!'),
                  TextButton(
                    onPressed: () {},
                    child: Text('Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).textTheme.button.color,
                ),
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
