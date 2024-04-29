import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/log_meal/nutrition_summary/nutrition_summary.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list_item/food_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';

class Ingredients extends StatelessWidget {
  const Ingredients({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          recipeInfo: (recipeState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NutritionValuesBlock(
                  numberOfPortions: recipeState.data.recipe.numberOfServings,
                  selectedNutritionType: recipeState.data.currentNutritionType,
                  nutritionValuesList: recipeState.data.recipe.nutritionValues,
                  onNutritionFactSelect: (NutritionValuesTypes item) => _onNutritionFactSelect(
                    context,
                    item,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: recipeState.data.recipe.ingredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = recipeState.data.recipe.ingredients[index];

                      return FoodListItem(
                        foodItem: FoodItem(
                          id: item.id,
                          foodName: item.foodName,
                          foodType: MealItemType.food,
                          brandName: item.brandName,
                          foodDescription: item.foodDescription,
                          serving: item.serving,
                        ),
                        nutritionKey: recipeState.data.currentNutritionType.name,
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 30.0),
                  decoration: const BoxDecoration(color: AppColors.greenLighter),
                  child: NutritionSummary(
                    proteinDegree: recipeState.data.recipe.proteinDegreeVal,
                    calorieDensity: recipeState.data.recipe.calorieDensityVal,
                    fiber: recipeState.data.recipe.fiberSum,
                    carbFiberRatio: recipeState.data.recipe.carbFiberRatio,
                  ),
                ),
              ],
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  void _onNutritionFactSelect(BuildContext context, NutritionValuesTypes item) {
    context.read<RecipeBloc>().add(RecipeEvent.nutritionItemChanged(item));
  }
}
