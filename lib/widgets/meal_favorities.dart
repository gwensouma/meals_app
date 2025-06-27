import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/providers/favorities_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealFavorities extends ConsumerWidget {
  const MealFavorities({super.key});

  void _selectMeal(BuildContext context, Meal selectMeal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(),
        settings: RouteSettings(arguments: selectMeal),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final activerFilters = ref.watch(filtersProvider);

    final availabelList = favoriteMeals.where((e) {
      if (activerFilters[Filter.glutenFree]! && !e.isGlutenFree) {
        return false;
      }
      if (activerFilters[Filter.lactoseFree]! && !e.isLactoseFree) {
        return false;
      }
      if (activerFilters[Filter.vegetarian]! && !e.isVegetarian) {
        return false;
      }
      if (activerFilters[Filter.vegan]! && !e.isVegan) {
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
