import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final VoidCallback _presentDatePicker;
  final String _title;

  const AdaptiveButton({super.key, presentDatePicker, title})
      : _presentDatePicker = presentDatePicker,
        _title = title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Platform.isIOS
        ? CupertinoButton(
            //  color: Colors.blue,
            child: Text(_title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            onPressed: _presentDatePicker,
          )
        : TextButton(
            onPressed: _presentDatePicker,
            child: Text(_title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                theme.primaryColor,
              ),
            ),
          );
  }
}
