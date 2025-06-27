import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/providers/favorities_provider.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final favoriteMeals = ref.watch(favoriteMealsProvider);
              final isExisting = favoriteMeals.contains(meal);

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween<double>(
                      begin: 0.5,
                      end: 1.0,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: IconButton(
                  onPressed: () {
                    final message = ref
                        .read(favoriteMealsProvider.notifier)
                        .toggleMealFavoritiesStatus(meal);

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  },
                  icon: isExisting
                      ? Icon(Icons.star)
                      : Icon(Icons.star_outline),
                  key: ValueKey(isExisting),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
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
