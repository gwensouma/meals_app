import 'package:flutter/material.dart';
import 'package:meals/widgets/filters_item.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this._selectedFilters, {super.key});
  final Map<Filter, bool> _selectedFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _veganFilterSet = false;
  var _vegetarianFilterSet = false;
  var _lactoseFreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget._selectedFilters[Filter.glutenFree]!;
    _veganFilterSet = widget._selectedFilters[Filter.vegan]!;
    _vegetarianFilterSet = widget._selectedFilters[Filter.vegetarian]!;
    _lactoseFreeFilterSet = widget._selectedFilters[Filter.lactoseFree]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) async {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            FiltersItem(
              _glutenFreeFilterSet,
              (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              'Glutten-free',
              'Only include gluten-free meals.',
            ),
            FiltersItem(
              _lactoseFreeFilterSet,
              (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              'Lactose-free',
              'Only include lactose-free meals.',
            ),
            FiltersItem(
              _vegetarianFilterSet,
              (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              'Vegetarian',
              'Only include vegetariant meals.',
            ),
            FiltersItem(
              _veganFilterSet,
              (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
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
