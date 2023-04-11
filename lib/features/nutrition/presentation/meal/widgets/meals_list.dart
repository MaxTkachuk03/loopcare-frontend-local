import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
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
            return mealsState.currentFoodItems.isEmpty
                ? const EmptyMeal()
                : ListView.builder(
                    itemCount: mealsState.currentFoodItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return FoodItem(
                        foodItem: mealsState.currentFoodItems[index],
                        onDeletePressed: _onDeletePressed,
                      );
                    },
                  );
          },
          loading: (_) => const SizedBox(height: 240, child: Loader()),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  void _onDeletePressed(
    BuildContext context,
    int? foodItemId,
  ) {
    if (foodItemId != null) {
      context.read<MealsBloc>().add(
            MealsEvent.deleteFoodItemFromMeal(foodItemId),
          );
    }
  }
}
