import 'package:fl_todo_app/data/dummy.dart';
import 'package:fl_todo_app/models/category.dart';
import 'package:fl_todo_app/models/meal.dart';
import 'package:fl_todo_app/screens/meals.dart';
import 'package:fl_todo_app/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoryScreem extends StatefulWidget {
  const CategoryScreem({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoryScreem> createState() => _CategoryScreemState();
}

class _CategoryScreemState extends State<CategoryScreem>
    with SingleTickerProviderStateMixin {
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
    _animationController.dispose();
    super.dispose();
  }

  void selectCategory(BuildContext context, CategorySet category) {
    final filteredMeal = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MealsScreen(title: category.title, meals: filteredMeal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticInOut,
          ),
        ),

        child: child,
      ),
    );
  }
}
