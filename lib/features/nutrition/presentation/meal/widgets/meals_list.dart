import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/add_food_item_to_meal_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/empty_meal.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list_item/food_list_item.dart';

class MealsList extends StatelessWidget {
  const MealsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          mealsInfo: (mealsState) {
            return mealsState.currentFoodItems.isEmpty
                ? const EmptyMeal()
                : ListView.builder(
                    itemCount: mealsState.currentFoodItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final item = mealsState.currentFoodItems[index];

                      return FoodListItem(
                        foodItem: FoodItem(
                          id: item.id.toString(),
                          foodName: item.name,
                          foodType: item.type,
                          brandName: item.description ?? '',
                          foodDescription: item.description,
                          serving: item.serving,
                        ),
                        nutritionKey: mealsState.currentNutritionType.name,
                        onDeletePressed: _onDeletePressed,
                        onTap: (BuildContext context) => _onTap(context, item),
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
    FoodItem item,
  ) {
    if (item.foodType == MealItemType.recipe) {
      context.read<MealsBloc>().add(MealsEvent.deleteRecipeFromMeal(item.id));

      return;
    }

    if (item.foodType == MealItemType.dish) {
      context.read<MealsBloc>().add(MealsEvent.deleteDishFromMeal(item.id));

      return;
    }

    if (item.foodType == MealItemType.food) {
      context.read<MealsBloc>().add(MealsEvent.deleteFoodItemFromMeal(item.id));
    }
  }

  void _onTap(BuildContext context, MealItem item) {
    if (item.type == MealItemType.recipe) {
      context.router.push(
        RecipeRoute(
          id: item.id,
          name: item.name,
          isMealRecipe: true,
        ),
      );

      return;
    }
    if (item.type == MealItemType.dish) {
      context.router.push(
        DishDetailsRoute(
          dishId: item.id,
          canEditDish: false,
          isMealDish: true,
        ),
      );

      return;
    }

    final servingId = item.serving.servingId;
    final externalId = item.externalId;
    final internalId = item.id;

    if (servingId == null || externalId == null) return;

    context.router.push(
      SelectServingRoute(
        foodItemId: externalId,
        initialServingId: servingId,
        initialServingAmount: item.serving.numberOfUnits,
        initialCaloriesValue: item.serving.calories,
        foodItemName: item.name,
        onConfirm: (double numberOfUnits, String servingId) {
          final mealId = context.read<MealsBloc>().state.mapOrNull(mealsInfo: (s) => s.currentMealId);

          if (mealId == null) return;

          context.read<MealsBloc>().add(
                MealsEvent.updateFoodItemInMeal(
                  mealId,
                  internalId,
                  AddFoodItemToMealBody(
                    servingId: servingId,
                    numberOfUnits: numberOfUnits,
                  ),
                ),
              );
        },
      ),
    );
  }
}
