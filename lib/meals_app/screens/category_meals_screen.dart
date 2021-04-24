import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;
  //
  // const CategoryMealsScreen({
  //   Key key,
  //   this.categoryId,
  //   this.categoryTitle,
  // }) : super(key: key);

  static const String routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> _displayMeals;
  String _categoryTitle;

  void _removeItem(String mealId) {
    setState(() {
      if (mealId != null) {
        _displayMeals.removeWhere(
          (meal) => meal.id == mealId,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    _categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    _displayMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            final meal = _displayMeals[index];
            return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              complexity: meal.complexity,
              affordability: meal.affordability,
              removeItem: _removeItem,
            );
          },
          itemCount: _displayMeals.length,
        ),
      ),
    );
  }
}
