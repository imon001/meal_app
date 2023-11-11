import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meals_model.dart';

class FavMealsNotifirer extends StateNotifier<List<Meal>> {
  FavMealsNotifirer() : super([]);
  bool addRemoveFavMeal(Meal meal) {
    final mealIsFav = state.contains(meal);
    if (mealIsFav) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [
        ...state,
        meal,
      ];
      return true;
    }
  }
}

final favMealProvider = StateNotifierProvider<FavMealsNotifirer, List<Meal>>((ref) {
  return FavMealsNotifirer();
});
