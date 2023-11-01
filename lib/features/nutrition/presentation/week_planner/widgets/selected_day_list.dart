import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/selected_day_card.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/grouped_meal_list/grouped_meal_list.dart';

class SelectedDayList extends StatelessWidget {
  final List<MealsListItem> mealsListItems;
  final bool active;

  const SelectedDayList({
    super.key,
    required this.mealsListItems,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Expanded(
        //   child:
        ListView.separated(
      shrinkWrap: true,
      itemCount: mealsListItems.length,
      itemBuilder: (BuildContext context, index) {
        final item = mealsListItems[index];
        // final type = item.type;
        // final prevType = index > 0 ? mealsListItems[index - 1].type : null;
        // final recipeNotation = type == MealItemType.recipe ? ' (${LocalizedTexts.recipe.translation})' : '';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SelectedDayCard(
            mealCategory: item.mealCategory,
            mealItems: item.mealItems,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 2.0);
      },
      // ),
    );
  }

  // AssetImage _getIcon(MealItemType type) {
  //   if (type == MealItemType.recipe) {
  //     return AppIcons.cook;
  //   }
  //   if (type == MealItemType.dish) {
  //     return AppIcons.pan;
  //   }

  //   return AppIcons.cutlery;
  // }
}
