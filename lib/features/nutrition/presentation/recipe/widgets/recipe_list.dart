import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/recipe/recipe_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list_item/food_list_item.dart';

class RecipeList extends StatelessWidget {
  final String nutritionKey;
  final List<FoodItem> list;

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
        return FoodListItem(
          foodItem: list[index],
          nutritionKey: nutritionKey,
          onDeletePressed: _onDeletePressed,
        );
      },
    );
  }

  void _onDeletePressed(BuildContext context, String id) {
    final mealId = context.read<MealsBloc>().state.getCurrentMealId;

    if (mealId == null) return;

    context.read<RecipeBloc>().add(
          RecipeEvent.removeFoodItemFromRecipe(
            mealId: mealId,
            foodItemId: id,
          ),
        );
  }
}
