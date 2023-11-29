import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/category_model.dart';
import '../models/meals_model.dart';
import '../widgets/category_gird_item.dart';
import 'meal_screen.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key, required this.availableMeal});
  final List<Meal> availableMeal;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 150,
        ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeal.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              meals: filteredMeals,
              title: category.title,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,

      //
      //
      //
      child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGirdItem(
                category: category,
                selectCategory: () {
                  _selectCategory(context, category);
                })
        ],
      ),
      //
      //
      //
      builder: (BuildContext context, Widget? child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.2),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
          child: child,
        );
      },
    );
  }
}
