import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/grouped_meal_list/grouped_meal_list.dart';

class AlreadyPlannedCard extends StatelessWidget {
  final List<MealItem> mealItems;
  final bool active;
  final String mealCategory;

  const AlreadyPlannedCard({
    super.key,
    required this.mealItems,
    required this.mealCategory,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 24.0,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1, color: active ? AppColors.anotherBlue : AppColors.yellowLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (active)
                  Text(
                    mealCategory.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.greyLabel),
                  ),
                if (!active)
                  Text(
                    LocalizedTexts.alreadyPlannedCategory.tr({'mealCategory': mealCategory.toUpperCase()}),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.greyLabel),
                  ),
                const SizedBox(height: 18.0),
                GroupedMealList(
                  mealItems: mealItems,
                  active: active,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, bottom: 30.0),
            child: GestureDetector(
              onTap: () => context.router.maybePop(),
              child: const ImageIcon(
                AppIcons.arrow,
                color: AppColors.anotherBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
