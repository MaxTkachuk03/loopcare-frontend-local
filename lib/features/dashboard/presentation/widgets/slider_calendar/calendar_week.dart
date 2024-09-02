import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CalendarWeek extends StatelessWidget {
  final Function(DateTime date) onPressHandler;
  final String weekNumber;
  final String fromDate;
  final String toDate;
  final String month;
  final DateTime date;
  final bool isSelected;
  final bool isFutureDate;

  const CalendarWeek({
    super.key,
    required this.onPressHandler,
    required this.weekNumber,
    required this.fromDate,
    required this.toDate,
    required this.month,
    required this.date,
    required this.isSelected,
    required this.isFutureDate,
  });

  Color _getDayColor() {
    return isSelected
        ? AppColors.bgGreen
        : isFutureDate
            ? AppColors.blueAppBar
            : AppColors.e3e5de;
  }

  Color _getTextColor() {
    return isSelected
        ? AppColors.darkGreen
        : isFutureDate
            ? AppColors.white
            : AppColors.weekDisabled;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressHandler(date),
      child: Container(
        width: 111,
        decoration: BoxDecoration(
          color: _getDayColor(),
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.darkGreen,
              spreadRadius: 1.5,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocalizedTexts.capitalizeWeekWithNumber.tr({'number': weekNumber}),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: _getTextColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: isSelected ? ThemeConstants.fontSize16 : ThemeConstants.fontSize14,
                  ),
            ),
            Text(
              LocalizedTexts.weekDates.tr({
                'from': fromDate,
                'to': toDate,
                'month': month,
              }),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: _getTextColor(),
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
