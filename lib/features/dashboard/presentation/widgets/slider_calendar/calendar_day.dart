import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CalendarDay extends StatelessWidget {
  final Function(DateTime day) onPressHandler;
  final DateTime day;
  final bool isSelected;
  final bool isFutureDate;

  const CalendarDay({
    Key? key,
    required this.onPressHandler,
    required this.day,
    required this.isSelected,
    required this.isFutureDate,
  }) : super(key: key);

  Color _getDayColor() {
    return isSelected
        ? AppColors.bgGreen
        : isFutureDate
            ? AppColors.blueAppBar
            : AppColors.blueMid;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressHandler(day),
      child: Container(
        width: 68,
        decoration: BoxDecoration(
          color: _getDayColor(),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.blueAppBar,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E').format(day),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: isSelected ? AppColors.darkGreen : AppColors.white,
                    decoration: isSelected
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              DateFormat('d').format(day),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isSelected ? AppColors.darkGreen : AppColors.white,
                  fontSize: 12.0),
            ),
            Text(
              DateFormat('MMM').format(day),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isSelected ? AppColors.darkGreen : AppColors.white,
                  fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
