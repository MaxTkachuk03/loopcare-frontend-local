import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/day_card_header.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/meal_category_list_item.dart';

class FilledDayCard extends StatelessWidget {
  final DateTime date;
  final List<MealsListItem> mealItems;
  final VoidCallback onPressHandler;

  const FilledDayCard({
    super.key,
    required this.date,
    required this.mealItems,
    required this.onPressHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0, bottom: 34.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DayCardHeader(date: date, onPressHandler: onPressHandler),
          const SizedBox(height: 6.0),
          Text(
            date.shortDate,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.darkGreen),
          ),
          const SizedBox(height: 18.0),
          const Divider(
            color: AppColors.bgGreen,
            thickness: 2.0,
            height: 2.0,
          ),
          const SizedBox(height: 6.0),
          ListView.separated(
            shrinkWrap: true,
            itemCount: mealItems.length,
            itemBuilder: (BuildContext context, index) {
              final item = mealItems[index];

              return MealCategoryListItem(
                date: date,
                mealCategory: item.mealCategory,
                mealItems: item.mealItems,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 2.0);
            },
          ),
          const SizedBox(height: 20.0),
          const Divider(
            color: AppColors.bgGreen,
            thickness: 2.0,
            height: 2.0,
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
