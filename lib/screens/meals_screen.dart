import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';
import 'package:meals/widgets/meal_favorities.dart';
import 'package:meals/widgets/test.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Category? category =
        ModalRoute.of(context)?.settings.arguments as Category?;
    if (category == null) {
      return Scaffold(body: MealFavorities());
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(category.title),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: TestFutureMeal(category.id),
      );
    }
  }
}
