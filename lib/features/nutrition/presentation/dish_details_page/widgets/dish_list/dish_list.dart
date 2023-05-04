import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/nutrition/application/dish/dish_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list_item/food_list_item.dart';

class DishList extends StatelessWidget {
  final String nutritionKey;
  final List<DishFoodItem> list;

  const DishList({
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
            id: item.id.toString(),
            foodName: item.foodName,
            foodType: item.brandName,
            brandName: item.brandName,
            foodDescription: null,
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
    // Original dish is not affected, only local version
    context.read<DishBloc>().add(DishEvent.deleteFoodItemFromDishLocally(
        foodItemId: int.parse(item.id)));
  }

  _onTap(BuildContext context, DishFoodItem item) {
    final servingId = item.serving.servingId;

    if (servingId == null) return;

    context.router.push(
      SelectServingRoute(
        foodItemId: item.externalId,
        initialServingId: servingId,
        initialServingAmount: item.serving.numberOfUnits,
        foodItemName: item.foodName,
        onConfirm: (double numberOfUnits, String servingId) {
          final dishId = context
              .read<DishBloc>()
              .state
              .mapOrNull(dish: (s) => s.selectedDish.id);

          if (dishId == null) return;

          context.read<DishBloc>().add(
                DishEvent.updateFoodItemInDish(
                  dishId: dishId,
                  internalFoodItemId: item.id.toString(),
                  numberOfUnits: numberOfUnits,
                  servingId: servingId,
                ),
              );
        },
      ),
    );
  }
}
