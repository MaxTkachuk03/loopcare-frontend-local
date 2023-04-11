import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/empty_meal.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_item/food_item.dart';

class MealsList extends StatelessWidget {
  const MealsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          meals: (mealsState) {
            return mealsState.currentFoodItems == null
                ? const EmptyMeal()
                : ListView.builder(
                    itemCount: mealsState.currentFoodItems?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return FoodItem(
                          foodItem: mealsState.currentFoodItems![index]);
                    },
                  );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
