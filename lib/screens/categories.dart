import 'package:fl_todo_app/data/dummy.dart';
import 'package:fl_todo_app/models/category.dart';
import 'package:fl_todo_app/models/meal.dart';
import 'package:fl_todo_app/screens/meals.dart';
import 'package:fl_todo_app/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoryScreem extends StatelessWidget {
  const CategoryScreem({
    super.key,
    
    required this.availableMeals,
  });

  
  final List<Meal> availableMeals;
  void selectCategory(BuildContext context, CategorySet category) {
    final filteredMeal = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filteredMeal,

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
