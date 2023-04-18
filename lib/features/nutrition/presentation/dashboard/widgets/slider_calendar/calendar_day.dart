import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/slider_calendar/slider_calendar.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CalendarDay extends StatelessWidget {
  final Function(Day day) onPressHandler;
  final Day day;
  final bool isSelected;

  const CalendarDay({
    Key? key,
    required this.onPressHandler,
    required this.day,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressHandler(day),
      child: Container(
        width: 68,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.bgGreen : AppColors.blueMid,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
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
              day.name,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: isSelected ? AppColors.darkGreen : AppColors.white,
                    decoration: isSelected
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              day.number,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: isSelected ? AppColors.darkGreen : AppColors.white,
                  fontSize: 12.0),
            ),
            Text(
              day.month,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: isSelected ? AppColors.darkGreen : AppColors.white,
                  fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
