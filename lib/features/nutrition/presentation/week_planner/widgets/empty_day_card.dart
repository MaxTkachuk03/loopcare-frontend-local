import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/empty_meal.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/week_planner/widgets/day_card_header.dart';

class EmptyDayCard extends StatelessWidget {
  final DateTime date;
  final VoidCallback onPressHandler;

  const EmptyDayCard({
    super.key,
    required this.date,
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
          const Gap(6.0),
          Text(
            date.shortDate,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.darkGreen),
          ),
          const Gap(18.0),
          const Divider(
            color: AppColors.bgGreen,
            thickness: 2.0,
            height: 2.0,
          ),
          const Gap(6.0),
          EmptyMeal(message: LocalizedTexts.nothingOnTheMenu.translation),
          const Gap(20.0),
          const Divider(
            color: AppColors.bgGreen,
            thickness: 2.0,
            height: 2.0,
          ),
          const Gap(30.0),
        ],
      ),
    );
  }
}
