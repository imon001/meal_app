import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/favorites_provider.dart';
import '../provider/filter_provider.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'filter_screen.dart';
import 'meal_screen.dart';

class MainHome extends ConsumerStatefulWidget {
  const MainHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainHomeState();
}

class _MainHomeState extends ConsumerState<MainHome> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    await Navigator.of(context).push<Map<Filter, bool>>(
      MaterialPageRoute(builder: (ctx) => const FilterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealProvider);
    Widget activePage = CategoriesView(
      availableMeal: availableMeals,
    );
    String activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      final favMeals = ref.watch(favMealProvider);

      activePage = MealsScreen(meals: favMeals);
      activePageTitle = "Favorites Meals";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_outlined),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_purple500),
            label: "Favourite",
          ),
        ],
      ),
    );
  }
}
