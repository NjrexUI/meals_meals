import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meals.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/settings_screen.dart';
import './screens/categories_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setValues(Map<String, bool> filterData) {
    setState(
      () {
        filters = filterData;

        // ignore: missing_return
        availableMeals = DUMMY_MEALS.where((meal) {
          if (filters["gluten"] && !meal.isGlutenFree) {
            return false;
          }
          if (filters["lactose"] && !meal.isLactoseFree) {
            return false;
          }
          if (filters["vegan"] && !meal.isVegan) {
            return false;
          }
          if (filters["vegetarian"] && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();
      },
    );
  }

  void toggleFavorite(String mealID) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealID);
    if (existingIndex >= 0) {
      setState(
        () {
          favoriteMeals.removeAt(existingIndex);
        },
      );
    } else {
      setState(() {
        favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealID),
        );
      });
    }
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meals) => meals.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              // ignore: deprecated_member_use
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              // ignore: deprecated_member_use
              title: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: TabsScreen(),
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals),
        CategoriesMealsScreen.routeName: (ctx) =>
            CategoriesMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(toggleFavorite, isMealFavorite),
        SettingsScreen.routeName: (ctx) => SettingsScreen(filters, setValues),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
