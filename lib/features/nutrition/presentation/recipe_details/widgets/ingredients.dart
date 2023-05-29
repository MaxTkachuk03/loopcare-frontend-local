import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/nutrition_instructions/widgets/nutrition_block/nutrition_block.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list_item/food_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions/nutrition_values_block.dart';

class Ingredients extends StatelessWidget {
  const Ingredients({
    Key? key,
  }) : super(key: key);

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
                  numberOfPortions: recipeState.recipe.numberOfServings,
                  selectedNutritionType: recipeState.currentNutritionType,
                  nutritionValuesList: recipeState.recipe.nutritionValues,
                  onNutritionFactSelect: (NutritionValuesTypes item) =>
                      _onNutritionFactSelect(
                    context,
                    item,
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: recipeState.recipe.ingredients.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = recipeState.recipe.ingredients[index];

                    return FoodListItem(
                      foodItem: FoodItem(
                        id: item.id,
                        foodName: item.foodName,
                        foodType: item.foodType,
                        brandName: item.brandName,
                        foodDescription: item.foodDescription,
                        serving: item.serving,
                      ),
                      nutritionKey: recipeState.currentNutritionType.name,
                    );
                  },
                ),
                NutritionBlock(
                  calorieDensity: recipeState.recipe.calorieDensity,
                  proteinDegree: recipeState.recipe.proteinDegree,
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
