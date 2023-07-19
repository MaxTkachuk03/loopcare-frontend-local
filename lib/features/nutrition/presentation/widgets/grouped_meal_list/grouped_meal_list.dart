import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';

class GroupedMealList extends StatelessWidget {
  final List<MealItem> mealItems;

  const GroupedMealList({
    super.key,
    required this.mealItems,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: mealItems.length,
      itemBuilder: (BuildContext context, index) {
        final item = mealItems[index];
        String type = item.type;
        String prevType = '';
        if (index > 0) prevType = mealItems[index - 1].type;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 30.0),
            if (type != prevType)
              Image(
                image: _getIcon(type),
                width: 16.0,
              ),
            if (type == prevType) const SizedBox(width: 16.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 2.0);
      },
    );
  }

  AssetImage _getIcon(String type) {
    if (type == 'recipe') {
      return AppIcons.cook;
    }
    if (type == 'dish') {
      return AppIcons.pan;
    }

    return AppIcons.cutlery;
  }
}
