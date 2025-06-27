import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/future_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  Category? category;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void getCategory(Category selectCategory) {
    setState(() {
      category = selectCategory;
    });
    _selectCategory(context);
  }

  void _selectCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(),
        settings: RouteSettings(arguments: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: FutureCategory((selectCategory) {
        getCategory(selectCategory);
      }),
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
        child: child,
      ),
    );
  }
}
