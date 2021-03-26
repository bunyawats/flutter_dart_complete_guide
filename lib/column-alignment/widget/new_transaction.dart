import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransactionCard extends StatelessWidget {
  final Function callBack;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransactionCard({Key key, this.callBack}) : super(key: key);

  void submitData() {
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    print('titleInput : $enterTitle');
    print('amountInput : $enterAmount');

    if (enterTitle.isEmpty || enterAmount <= 0) {
      return;
    }
    callBack(
      titleController.text,
      double.parse(amountController.text),
    );
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
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[-+.0-9]'))],
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              onPressed: submitData,
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
