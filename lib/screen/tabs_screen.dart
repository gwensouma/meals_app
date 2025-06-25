import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screen/categories_screen.dart';
import 'package:meals/screen/filters_screen.dart';
import 'package:meals/screen/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndexPage = 0;
  List<Meal> listFavoritesMeal = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void setPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoritesStatus(Meal meal) {
    final isExisting = listFavoritesMeal.map((e) => e.id).contains(meal.id);

    if (!isExisting) {
      setState(() {
        listFavoritesMeal.add(meal);
        _showMessage('Add ${meal.title} successfully');
      });
    } else {
      setState(() {
        listFavoritesMeal.remove(meal);
        _showMessage('Remove ${meal.title} successfully');
      });
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(_selectedFilters),
        ),
      );
      if (result != null) {
        setState(() {
          _selectedFilters = result;
        });
      }
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      _selectedFilters,
      listFavoritesMeal,
      _toggleMealFavoritesStatus,
    );

    if (_selectedIndexPage == 1) {
      activePage = MealsScreen(
        _selectedFilters,
        listFavoritesMeal,
        _toggleMealFavoritesStatus,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Meals App'),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: MainDrawer(_setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndexPage,
        onTap: (index) {
          setPage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
