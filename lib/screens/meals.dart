import 'package:fl_todo_app/models/meal.dart';
import 'package:fl_todo_app/screens/meal_details.dart';
import 'package:fl_todo_app/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
   
  });

  final String? title;
  final List<Meal> meals;
  

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealDetails(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = meals.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Uh oh... No meals here',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Try another Category",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.black),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              return MealItem(
                meal: meals[index],
                chosenMeal: (context, meal) {
                  selectMeal(context, meal);
                },
              );
            },
          );

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: Container(child: content),
    );
  }
}
