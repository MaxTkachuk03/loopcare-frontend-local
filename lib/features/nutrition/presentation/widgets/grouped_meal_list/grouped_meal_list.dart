import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_item_type/meal_item_type.dart';

class GroupedMealList extends StatelessWidget {
  final List<MealItem> mealItems;
  final bool active;

  const GroupedMealList({
    super.key,
    required this.mealItems,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mealItems.length,
      itemBuilder: (BuildContext context, index) {
        final item = mealItems[index];
        final type = item.type;

        final recipeNotation = type == MealItemType.recipe ? ' (${LocalizedTexts.recipe.translation})' : '';

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomText.w400(
                '${item.name}$recipeNotation',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 2.0);
      },
    );
  }
}
