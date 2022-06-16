import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../widgets/meal_item.dart';

class CategoriesMealsScreen extends StatelessWidget {
  static const routeName = "/categories-meals";

  final List<Meal> availableMeals;

  CategoriesMealsScreen(this.availableMeals);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final catTitle = routeArgs["title"];
    final catId = routeArgs["id"];
    final catMeals = availableMeals.where((meal) {
      return meal.categories.contains(catId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: catMeals[index].id,
            title: catMeals[index].title,
            imageUrl: catMeals[index].imageUrl,
            duration: catMeals[index].duration,
            affordability: catMeals[index].affordability,
            complexity: catMeals[index].complexity,
          );
        },
        itemCount: catMeals.length,
      ),
    );
  }
}
