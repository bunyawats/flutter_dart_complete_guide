import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;
  //
  // const CategoryMealsScreen({
  //   Key key,
  //   this.categoryId,
  //   this.categoryTitle,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final String categoryId = routeArgs['id'];
    final String categoryTitle = routeArgs['title'];

    return Scaffold(
      appBar: AppBar(
        title: Text('The Recipes'),
      ),
      body: Center(
        child: Text('The Recipes For The Category! $categoryTitle'),
      ),
    );
  }
}
