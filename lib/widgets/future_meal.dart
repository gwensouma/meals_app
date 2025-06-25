import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/filters_screen.dart';
import 'package:meals/screen/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class FutureMeal extends StatefulWidget {
  const FutureMeal(
    this.availabelMeals,
    this.favoritiesMeal,
    this.onToggleFavoritesMeal,
    this.id, {
    super.key,
  });

  final Map<Filter, bool> availabelMeals;
  final String id;
  final void Function(Meal meal) onToggleFavoritesMeal;
  final List<Meal> favoritiesMeal;

  @override
  State<FutureMeal> createState() => _FutureMealState();
}

class _FutureMealState extends State<FutureMeal> {
  late Future<List<Meal>> _futureMeal;

  bool _hasLoadedMeal = false;

  @override
  void initState() {
    super.initState();
    _futureMeal = loadMeal();
    print('fetched categorys');
  }

  void _selectMeal(BuildContext context, Meal selectMeal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          widget.favoritiesMeal,
          widget.onToggleFavoritesMeal,
        ),
        settings: RouteSettings(arguments: selectMeal),
      ),
    );
  }

  FutureBuilder<List<Meal>> buildMeal() {
    return FutureBuilder(
      future: _futureMeal,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text("error fetching");
        } else if (snapshot.hasData) {
          final data = snapshot.data!;

          if (!_hasLoadedMeal) {
            _hasLoadedMeal = true;
          }

          final availabelList = data.where((e) {
            if (widget.availabelMeals[Filter.glutenFree]! && !e.isGlutenFree) {
              return false;
            }
            if (widget.availabelMeals[Filter.lactoseFree]! &&
                !e.isLactoseFree) {
              return false;
            }
            if (widget.availabelMeals[Filter.vegetarian]! && !e.isVegetarian) {
              return false;
            }
            if (widget.availabelMeals[Filter.vegan]! && !e.isVegan) {
              return false;
            }
            return true;
          }).toList();

          final fromCategory = availabelList
              .where((e) => e.categories.contains(widget.id))
              .toList();
          if (fromCategory.isEmpty) {
            return Center(
              child: Text(
                'Null Data',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.amber),
              ),
            );
          }
          return ListView.builder(
            itemCount: fromCategory.length,
            itemBuilder: (context, index) {
              return MealItem(fromCategory[index], (meal) {
                _selectMeal(context, meal);
              });
            },
          );
        }
        return Text('null data');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMeal();
  }
}

Future<String> _loadMealAsset() async {
  return await rootBundle.loadString('assets/data/meal_data.json');
}

Future<List<Meal>> loadMeal() async {
  String jsonString = await _loadMealAsset();
  final List<dynamic> jsonResponse = json.decode(jsonString);

  return jsonResponse.map((item) => Meal.fromJson(item)).toList();
}
