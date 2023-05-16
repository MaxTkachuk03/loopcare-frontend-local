import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

class MealCategoryChips extends StatelessWidget {
  final List<MealCategory> data;
  final List<MealCategory> selectedChips;
  final Function onItemPressHandler;

  const MealCategoryChips({
    Key? key,
    required this.data,
    required this.selectedChips,
    required this.onItemPressHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: data.map((item) {
        final isSelected = selectedChips.contains(item);

        return ActionChip(
          labelPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 1.0,
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: isSelected ? AppColors.blueDark : AppColors.blueMid,
          avatar: Icon(
            Icons.check,
            color: isSelected ? AppColors.white : AppColors.blueLight,
          ),
          label: Text(item.name),
          onPressed: () => onItemPressHandler(item),
        );
      }).toList(),
    );
  }
}
