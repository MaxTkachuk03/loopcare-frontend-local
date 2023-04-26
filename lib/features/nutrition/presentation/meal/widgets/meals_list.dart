import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
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
                        nutritionKey: 'calories',
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
    if (item.foodType == 'recipe') {
      context.read<MealsBloc>().add(MealsEvent.deleteRecipeFromMeal(item.id));

      return;
    }

    if (item.foodType == 'food') {
      context.read<MealsBloc>().add(MealsEvent.deleteFoodItemFromMeal(item.id));
    }
  }

  void _onTap(BuildContext context, MealItem item) {
    if (item.type == 'recipe') {
      context.router.push(RecipeRoute(
        id: item.id,
        name: item.name,
        isMealRecipe: true,
      ));

      return;
    }

    final servingId = item.serving.servingId;

    if (servingId == null) return;

    context.router.push(
      SelectServingRoute(
          foodItemId: item.externalId,
          initialServingId: servingId,
          foodItemName: item.name),
    );
  }
}
