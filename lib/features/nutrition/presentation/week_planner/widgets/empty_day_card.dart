import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/meal/widgets/empty_meal.dart';

class EmptyDayCard extends StatelessWidget {
  final DateTime date;
  final VoidCallback onPressHandler;

  const EmptyDayCard({
    Key? key,
    required this.date,
    required this.onPressHandler,
  }) : super(key: key);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                date.weekdayString,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.blueAppBar),
              ),
              if (date.isToday)
                Text(
                  LocalizedTexts.today.translation.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.blueAppBar,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              if (date.isAfter(DateTime.now()))
                Hexagon(
                  width: 42,
                  height: 42,
                  borderRadius: 16,
                  innerWidget: Container(
                    color: AppColors.blueMid,
                    child: IconButton(
                      icon: const ImageIcon(
                        AppIcons.plus,
                        color: AppColors.white,
                        size: 12,
                      ),
                      onPressed: () => onPressHandler(),
                    ),
                  ),
                )
            ],
          ),
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
