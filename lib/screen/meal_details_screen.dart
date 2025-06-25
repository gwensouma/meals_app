import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen(
    this.favoritiesMeal,
    this.onToggleFavoritesMeal, {
    super.key,
  });

  final void Function(Meal meal) onToggleFavoritesMeal;
  final List<Meal> favoritiesMeal;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  var a = '';

  void reload() {
    final b = 'b';
    setState(() {
      a = b;
    });
    print(a);
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;
    final isExisting = widget.favoritiesMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            onPressed: () {
              widget.onToggleFavoritesMeal(meal);
              reload();
            },
            icon: isExisting ? Icon(Icons.star) : Icon(Icons.star_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12.0),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            for (var ingre in meal.ingredients)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(ingre, style: TextStyle(color: Colors.white)),
              ),
            const SizedBox(height: 12.0),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (var step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
