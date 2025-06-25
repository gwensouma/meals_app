import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/filters_screen.dart';
import 'package:meals/widgets/future_meal.dart';
import 'package:meals/widgets/meal_favorities.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
    this.availabelMeals,
    this.favoritiesMeal,
    this.onToggleFavoritesMeal, {
    super.key,
  });

  final void Function(Meal meal) onToggleFavoritesMeal;
  final List<Meal> favoritiesMeal;
  final Map<Filter, bool> availabelMeals;

  @override
  Widget build(BuildContext context) {
    final Category? category =
        ModalRoute.of(context)?.settings.arguments as Category?;
    if (category == null) {
      return Scaffold(
        body: MealFavorities(
          availabelMeals,
          favoritiesMeal,
          onToggleFavoritesMeal,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(category.title),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: FutureMeal(
          availabelMeals,
          favoritiesMeal,
          onToggleFavoritesMeal,
          category.id,
        ),
      );
    }
  }
}
