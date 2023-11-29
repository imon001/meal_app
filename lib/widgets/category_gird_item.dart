import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryGirdItem extends StatelessWidget {
  const CategoryGirdItem({super.key, required this.category, required this.selectCategory});

  final Category category;
  final void Function() selectCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectCategory,
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.5),
                category.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                //  color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
