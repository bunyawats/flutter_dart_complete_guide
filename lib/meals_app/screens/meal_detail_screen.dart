import 'package:flutter/material.dart';

class MeralDetailScreen extends StatelessWidget {
  static const String routeName = '/meal_detail';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final meralTitle = routeArgs['title'];

    return Scaffold(
      appBar: AppBar(
        title: Text(meralTitle),
      ),
      body: Center(
        child: Text(meralTitle),
      ),
    );
  }
}
