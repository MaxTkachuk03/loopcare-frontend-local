import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
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
    Key? key,
    required this.mealItems,
    required this.mealCategory,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 24.0,
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
                    LocalizedTexts.alreadyPlannedCategory,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.greyLabel),
                  ).tr(
                    namedArgs: {'mealCategory': mealCategory.toUpperCase()},
                  ),
                const SizedBox(height: 18.0),
                GroupedMealList(
                  mealItems: mealItems,
                  active: active,
                ),
                // const SizedBox(height: 30.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, bottom: 30.0),
            child: GestureDetector(
              onTap: () => context.router.pop(),
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
