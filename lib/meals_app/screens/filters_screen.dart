import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = '/filters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
     drawer: MainDrawer(),
      body: Center(
        child: Text(
          'Filters!',
        ),
      ),
    );
  }
}
