import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dish_food_item/dish_food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/food_list_item/food_list_item.dart';

class DishList extends StatelessWidget {
  final String nutritionKey;
  final List<DishFoodItem> list;
  final bool isScrollable;
  final Function(BuildContext context, FoodItem item) onDeleteHandler;
  final Function(BuildContext context, DishFoodItem item) onListItemTapHandler;

  const DishList({
    Key? key,
    required this.list,
    required this.nutritionKey,
    required this.onDeleteHandler,
    required this.onListItemTapHandler,
    required this.isScrollable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: !isScrollable,
      physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
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
          onDeletePressed: onDeleteHandler,
          onTap: (BuildContext context) => onListItemTapHandler(
            context,
            item,
          ),
        );
      },
    );
  }
}
