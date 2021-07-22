import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MeralDetailScreen extends StatelessWidget {
  static const String routeName = '/meal_detail';

  final Function toggleFavorite;
  final Function isMealFavorite;

  const MeralDetailScreen({Key key, this.toggleFavorite, this.isMealFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
        appBar: AppBar(
          title: Text('${selectedMeal.title}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                  child: ListView.builder(
                itemBuilder: (ctx, index) {
                  var ingredient = selectedMeal.ingredients[index];
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(ingredient),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              )),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                  child: ListView.builder(
                itemBuilder: (ctx, index) {
                  var step = selectedMeal.steps[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(step),
                      ),
                      Divider(),
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              isMealFavorite(mealId) ? Icons.star : Icons.star_border,
            ),
            onPressed: () {
              toggleFavorite(mealId);
              //Navigator.of(context).pop(mealId);
            }));
  }

  Container buildContainer({child: Widget}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  Container buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
