import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item_traits.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meals_model.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meals, required this.onclick});
  final Meal meals;

  final void Function(BuildContext context, Meal meal) onclick;

  String get complexityText {
    return meals.complexity.name[0].toUpperCase() + meals.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meals.affordability.name[0].toUpperCase() + meals.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: () {
          onclick(context, meals);
        },
        child: Stack(
          children: [
            Hero(
                tag: meals.id,
                child: FadeInImage(
                  image: NetworkImage(meals.imageUrl),
                  placeholder: MemoryImage(kTransparentImage),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: const Color.fromARGB(222, 0, 0, 0).withOpacity(0.4),
                  child: Column(
                    children: [
                      Text(
                        meals.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTraits(icon: Icons.schedule, label: "${meals.duration} min"),
                          const SizedBox(
                            width: 5,
                          ),
                          MealItemTraits(icon: Icons.work, label: complexityText),
                          const SizedBox(
                            width: 5,
                          ),
                          MealItemTraits(icon: Icons.attach_money_outlined, label: affordabilityText)
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
