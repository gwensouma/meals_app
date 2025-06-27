import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/providers/future_meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
      return FiltersNotifier();
    });

final filteredMealsProvider = Provider<AsyncValue<List<Meal>>>((ref) {
  final meals = ref.watch(configProvider);
  final activeFilters = ref.watch(filtersProvider);

  return switch (meals) {
    AsyncData<List<Meal>>(:final List<Meal> value) => AsyncData(
      value.where((Meal e) {
        if (activeFilters[Filter.glutenFree]! && !e.isGlutenFree) {
          return false;
        }
        if (activeFilters[Filter.lactoseFree]! && !e.isLactoseFree) {
          return false;
        }
        if (activeFilters[Filter.vegetarian]! && !e.isVegetarian) {
          return false;
        }
        if (activeFilters[Filter.vegan]! && !e.isVegan) {
          return false;
        }
        return true;
      }).toList(),
    ),
    AsyncError(:final error) => AsyncError(
      error,
      StackTrace.current,
    ), // Return AsyncError
    _ => const AsyncLoading(), // Return AsyncLoading
  };
});
