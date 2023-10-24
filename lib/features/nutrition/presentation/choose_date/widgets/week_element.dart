import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/domain/choose_date/week_day_element.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/choose_date/widgets/day_element.dart';

class WeekElement extends StatelessWidget {
  final List<WeekDayElement> weekElements;
  final String weekNumber;
  final Function(DateTime day) onPressHandler;

  const WeekElement({
    Key? key,
    required this.weekNumber,
    required this.weekElements,
    required this.onPressHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                LocalizedTexts.weekWithNumber,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: ThemeConstants.fontSize12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGreen,
                    ),
              ).tr(
                namedArgs: {'number': weekNumber},
              ),
            ),
            const Expanded(
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.darkGreen,
              ),
            )
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekElements
              .map(
                (entry) => DayElement(
                  dayElement: entry,
                  onPressHandler: onPressHandler,
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
