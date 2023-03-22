import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/default_list_item/default_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/selected_list_item/selected_list_item.dart';

class ServingListItem extends StatelessWidget {
  final FoodItemServing item;
  final bool isSelected;
  final TextEditingController inputController;
  final void Function(FoodItemServing item) onPressed;

  const ServingListItem({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onPressed,
    required this.inputController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? SelectedListItem(
            item: item, onPressed: onPressed, inputController: inputController)
        : DefaultListItem(item: item, onPressed: onPressed);
  }
}
