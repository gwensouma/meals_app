import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndexPage = 0;

  void setPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen();

    if (_selectedIndexPage == 1) {
      activePage = MealsScreen();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
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
