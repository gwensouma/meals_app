import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  String toggleMealFavoritiesStatus(Meal meal) {
    final mealIsFavorities = state.contains(meal);
    if (!mealIsFavorities) {
      state = [...state, meal];
      return 'Add ${meal.title} successfully!';
    } else {
      state = state.where((e) => e.id != meal.id).toList();
      return 'Remove ${meal.title} successfully!';
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
      return FavoriteMealsNotifier();
    });
