import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'adaptive_button.dart';

class NewTransactionCard extends StatefulWidget {
  final Function callBack;

  NewTransactionCard({Key key, this.callBack}) : super(key: key);

  @override
  _NewTransactionCardState createState() => _NewTransactionCardState();
}

class _NewTransactionCardState extends State<NewTransactionCard> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

    print('titleInput : $enterTitle');
    print('amountInput : $enterAmount');

    if ((enterTitle.isEmpty || enterAmount <= 0) || (_selectedDate == null)) {
      return;
    }
    widget.callBack(
      txTitle: _titleController.text,
      txAmount: double.parse(_amountController.text),
      txDate: _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    _selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
    print('$_selectedDate');
    setState(() => _selectedDate = _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[-+.0-9]')),
                ],
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate != null
                          ? 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'
                          : 'No Date Chosen!'),
                    ),
                    AdaptiveButton(
                      title: 'Choose Date',
                      presentDatePicker: _presentDatePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    theme.textTheme.button.color,
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
