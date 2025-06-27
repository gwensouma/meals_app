import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class TestFutureMeal extends ConsumerWidget {
  const TestFutureMeal(this.category, {super.key});

  final String category;

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
    final mealsAsync = ref.watch(filteredMealsProvider);
    return switch (mealsAsync) {
      AsyncData(:final value) => () {
        final listMealsFromCategory = value
            .where((meal) => meal.categories.contains(category))
            .toList();
        if (listMealsFromCategory.isEmpty) {
          return Center(
            child: Text(
              'Nothing!',
              style: TextStyle(fontSize: 40, color: Colors.amber),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: listMealsFromCategory.length,
            itemBuilder: (ctx, index) {
              return MealItem(
                listMealsFromCategory[index],
                (meal) => _selectMeal(context, meal),
              );
            },
          );
        }
      }(),
      AsyncError(:final error) => Text('Error: $error'),
      _ => const CircularProgressIndicator(),
    };
  }
}
