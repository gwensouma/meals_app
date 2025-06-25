import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/filters_screen.dart';
import 'package:meals/screen/meals_screen.dart';
import 'package:meals/widgets/future_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
    this.availabelMeals,
    this.listFavorities,
    this.onToggleFavoritesMeal, {
    super.key,
  });

  final void Function(Meal meal) onToggleFavoritesMeal;
  final List<Meal> listFavorities;
  final Map<Filter, bool> availabelMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Category? category;

  void getCategory(Category selectCategory) {
    setState(() {
      category = selectCategory;
    });
    _selectCategory(context);
  }

  void _selectCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          widget.availabelMeals,
          widget.listFavorities,
          widget.onToggleFavoritesMeal,
        ),
        settings: RouteSettings(arguments: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureCategory((selectCategory) {
        getCategory(selectCategory);
      }),
    );
  }
}
