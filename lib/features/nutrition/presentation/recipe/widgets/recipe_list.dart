import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_parameters.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list_item/food_list_item.dart';

class RecipeList extends StatelessWidget {
  final bool isMealRecipe;
  final String nutritionKey;
  final List<RecipeFoodItem> list;
  final bool isDisabled;

  const RecipeList({
    super.key,
    required this.isMealRecipe,
    required this.list,
    required this.nutritionKey,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final item = list[index];

        return FoodListItem(
          foodItem: FoodItem(
            id: item.id,
            foodName: item.foodName,
            foodType: MealItemType.food,
            brandName: item.brandName,
            foodDescription: item.foodDescription,
            serving: item.serving,
          ),
          nutritionKey: nutritionKey,
          onDeletePressed: isDisabled ? null : _onDeletePressed,
          onTap: isDisabled ? null : (BuildContext context) => _onTap(context, item),
        );
      },
    );
  }

  void _onDeletePressed(BuildContext context, FoodItem item) {
    final mealState = context.read<MealsBloc>().state;
    final recipeState = context.read<RecipeBloc>().state;
    final mealId = mealState.data.getCurrentMealId;
    final recipeId = !isMealRecipe
        ? mealState.data.currentFoodItems
            .firstWhere((element) =>
                element.type == MealItemType.recipe && element.externalId == recipeState.externalRecipeId)
            .id
        : recipeState.recipeId;

    if (mealId == null || recipeId == null) return;

    context.read<RecipeBloc>().add(
          RecipeEvent.removeFoodItemFromRecipe(
            mealId: mealId,
            recipeId: recipeId,
            foodItemId: item.id,
          ),
        );
  }

  _onTap(BuildContext context, RecipeFoodItem item) {
    final servingId = item.serving.servingId;

    if (servingId == null) return;

    context.router.push(
      SelectServingRoute(
        foodItemId: item.externalId,
        initialServingId: servingId,
        initialServingAmount: item.serving.numberOfUnits,
        initialCaloriesValue: item.serving.calories,
        foodItemName: item.foodName,
        onConfirm: (double numberOfUnits, String servingId) {
          final mealState = context.read<MealsBloc>().state;
          final recipeState = context.read<RecipeBloc>().state;
          final mealId = mealState.data.getCurrentMealId;

          final recipeId = !isMealRecipe
              ? mealState.data.currentFoodItems
                  .firstWhere((element) =>
                      element.type == MealItemType.recipe &&
                      element.externalId == recipeState.externalRecipeId)
                  .id
              : recipeState.recipeId;

          if (mealId == null || recipeId == null) return;

          context.read<RecipeBloc>().add(
                RecipeEvent.updateFoodItemFromRecipe(
                  mealId: mealId,
                  recipeId: recipeId,
                  foodItemId: item.id,
                  numberOfUnits: numberOfUnits,
                  servingId: servingId,
                ),
              );

          const AnalyticsEventService().logEvent(eventName:
            AnalyticsEvents.foodLogged,
            parameters: {
              AnalyticsParameters.timestamp: DateTime.now().toIso8601String(),
              AnalyticsParameters.mealId: mealId.toString(),
              AnalyticsParameters.foodItem: item.id,
              AnalyticsParameters.servingId: servingId,
              AnalyticsParameters.numberOfUnits: numberOfUnits.toString(),
              AnalyticsParameters.isRecipe: 'true',
            },
          );
        },
      ),
    );
  }
}
