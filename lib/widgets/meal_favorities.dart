import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/filters_screen.dart';
import 'package:meals/screen/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealFavorities extends StatelessWidget {
  const MealFavorities(
    this.availabelMeals,
    this.favoritiesMeal,
    this.onToggleFavoritesMeal, {
    super.key,
  });

  final List<Meal> favoritiesMeal;
  final void Function(Meal meal) onToggleFavoritesMeal;
  final Map<Filter, bool> availabelMeals;

  void _selectMeal(BuildContext context, Meal selectMeal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealDetailsScreen(favoritiesMeal, onToggleFavoritesMeal),
        settings: RouteSettings(arguments: selectMeal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availabelList = favoritiesMeal.where((e) {
      if (availabelMeals[Filter.glutenFree]! && !e.isGlutenFree) {
        return false;
      }
      if (availabelMeals[Filter.lactoseFree]! && !e.isLactoseFree) {
        return false;
      }
      if (availabelMeals[Filter.vegetarian]! && !e.isVegetarian) {
        return false;
      }
      if (availabelMeals[Filter.vegan]! && !e.isVegan) {
        return false;
      }
      return true;
    }).toList();
    return ListView.builder(
      itemCount: availabelList.length,
      itemBuilder: (context, index) {
        return MealItem(availabelList[index], (meal) {
          _selectMeal(context, meal);
        });
      },
    );
  }
}
