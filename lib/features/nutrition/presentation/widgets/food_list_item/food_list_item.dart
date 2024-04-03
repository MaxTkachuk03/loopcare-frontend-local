import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/calorie_density_color.dart';
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
      label = LocalizedTexts.recipe.tr();
    } else if (foodItem.foodType == MealItemType.dish) {
      label = LocalizedTexts.myDish.tr();
    } else {
      label = foodItem.brandName ?? '';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: 70,
      child: InkWell(
        onTap: onTap == null ? null : () => onTap?.call(context),
        child: Ink(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: AppColors.greenLighter)),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (onDeletePressed != null)
                    CustomIconButton.close(
                      onPressed: () => onDeletePressed?.call(context, foodItem),
                    ),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: getCalorieDensityColor(foodItem.calorieDensity),
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 13.0, bottom: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.w600(
                        foodItem.foodName,
                        maxLines: 1,
                        style: context.textTheme.bodySmall?.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      CustomText.w400(
                        '${foodItem.serving.servingSizeLabel} | $label',
                        maxLines: 1,
                        style: context.textTheme.bodySmall?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              Row(
                children: [
                  CustomText.w400(
                      '${currentNutritionFact.value.toStringAsFixed(2)} ${LocalizedTexts.kcal.tr()}',
                      style: context.textTheme.bodySmall),
                  if (onTap != null)
                    const SizedBox(
                      width: 44,
                      child: ImageIcon(
                        AppIcons.arrow,
                        color: AppColors.blueDarker,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
