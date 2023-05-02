import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/recipe_food_item/recipe_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list_item/food_list_item.dart';

class RecipeList extends StatelessWidget {
  final String nutritionKey;
  final List<RecipeFoodItem> list;

  const RecipeList({
    Key? key,
    required this.list,
    required this.nutritionKey,
  }) : super(key: key);

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
            foodType: item.foodType,
            brandName: item.brandName,
            foodDescription: item.foodDescription,
            serving: item.serving,
          ),
          nutritionKey: nutritionKey,
          onDeletePressed: _onDeletePressed,
          onTap: (BuildContext context) => _onTap(
            context,
            item,
          ),
        );
      },
    );
  }

  void _onDeletePressed(BuildContext context, FoodItem item) {
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;

    if (mealId == null) return;

    context.read<RecipeBloc>().add(
          RecipeEvent.removeFoodItemFromRecipe(
            mealId: mealId,
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
        foodItemName: item.foodName,
        onConfirm: (double numberOfUnits, String servingId) {
          final mealId = context.read<MealsBloc>().state.getCurrentMealId;

          if (mealId == null) return;

          context.read<RecipeBloc>().add(
                RecipeEvent.updateFoodItemFromRecipe(
                  mealId: mealId,
                  foodItemId: item.id,
                  numberOfUnits: numberOfUnits,
                  servingId: servingId,
                ),
              );
        },
      ),
    );
  }
}
