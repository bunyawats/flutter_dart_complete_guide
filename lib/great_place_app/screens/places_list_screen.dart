import 'package:flutter/material.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Yoy Place'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
