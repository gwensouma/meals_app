import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/filters_item.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) async {
          if (didPop) return;
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: activeFilters[Filter.glutenFree]!,
            Filter.lactoseFree: activeFilters[Filter.lactoseFree]!,
            Filter.vegetarian: activeFilters[Filter.vegetarian]!,
            Filter.vegan: activeFilters[Filter.vegan]!,
          });
          Navigator.of(context).pop();
        },
        child: Column(
          children: [
            FiltersItem(
              activeFilters[Filter.glutenFree]!,
              (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked);
              },
              'Glutten-free',
              'Only include gluten-free meals.',
            ),
            FiltersItem(
              activeFilters[Filter.lactoseFree]!,
              (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, isChecked);
              },
              'Lactose-free',
              'Only include lactose-free meals.',
            ),
            FiltersItem(
              activeFilters[Filter.vegetarian]!,
              (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegetarian, isChecked);
              },
              'Vegetarian',
              'Only include vegetariant meals.',
            ),
            FiltersItem(
              activeFilters[Filter.vegan]!,
              (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegan, isChecked);
              },
              'Vegan',
              'Only include vegan meals.',
            ),
          ],
        ),
      ),
    );
  }
}
