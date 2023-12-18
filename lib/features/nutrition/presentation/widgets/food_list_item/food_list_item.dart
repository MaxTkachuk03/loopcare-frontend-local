import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/calorie_density_color.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/domain/food_item/food_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';

class FoodListItem extends StatelessWidget {
  final String nutritionKey;
  final FoodItem foodItem;
  final void Function(BuildContext context)? onTap;
  final void Function(BuildContext context, FoodItem item)? onDeletePressed;

  const FoodListItem({
    super.key,
    required this.nutritionKey,
    required this.foodItem,
    this.onDeletePressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final NutritionItem currentNutritionFact =
        foodItem.serving.list.firstWhere((element) => element.key == nutritionKey);

    String label;

    if (foodItem.foodType == MealItemType.recipe) {
      label = LocalizedTexts.recipe.translation;
    } else if (foodItem.foodType == MealItemType.dish) {
      label = LocalizedTexts.myDish.translation;
    } else {
      label = foodItem.brandName ?? '';
    }

    return Material(
      child: InkWell(
        onTap: onTap == null ? null : () => onTap?.call(context),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: AppColors.yellowLight),
            ),
            color: AppColors.white,
          ),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(6),
              1: FlexColumnWidth(2),
              2: IntrinsicColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (onDeletePressed != null)
                          Row(
                            children: [
                              SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: IconButton(
                                  splashRadius: 20,
                                  padding: EdgeInsets.zero,
                                  iconSize: 22,
                                  onPressed: () => onDeletePressed?.call(context, foodItem),
                                  icon: const Icon(
                                    Icons.close,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                            ],
                          ),
                        Hexagon(
                          width: 20,
                          height: 20,
                          borderRadius: 10,
                          innerWidget: Container(color: getCalorieDensityColor(foodItem.calorieDensity)),
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodItem.foodName,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                label,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.greyLabel,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    foodItem.serving.servingSizeLabel,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(currentNutritionFact.value.toStringAsFixed(2), style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(
                        width: 4.0,
                      ),
                      if (onTap != null)
                        const ImageIcon(
                          AppIcons.arrow,
                          color: AppColors.greyLabel,
                          size: 10,
                        ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
