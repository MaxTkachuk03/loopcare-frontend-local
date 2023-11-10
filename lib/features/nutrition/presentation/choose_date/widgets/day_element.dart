import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/domain/choose_date/week_day_element.dart';

class DayElement extends StatelessWidget {
  final WeekDayElement dayElement;
  final Function(DateTime day) onPressHandler;

  const DayElement({
    Key? key,
    required this.dayElement,
    required this.onPressHandler,
  }) : super(key: key);

  Color _getDayBgColor() {
    return dayElement.enabled
        ? dayElement.selected
            ? AppColors.blueAppBar
            : AppColors.white
        : AppColors.disabledElement;
  }

  Color _getDayTextColor() {
    return dayElement.enabled
        ? dayElement.filled || dayElement.selected
            ? AppColors.white
            : AppColors.black
        : AppColors.disabledText;
  }

  Color _getDateTextColor() {
    return dayElement.enabled
        ? dayElement.selected
            ? AppColors.white
            : AppColors.black
        : AppColors.disabledText;
  }

  Color _getHexagonBgColor() {
    return dayElement.enabled
        ? dayElement.filled || dayElement.selected
            ? AppColors.blueAppBar
            : AppColors.bgGreen
        : AppColors.disabledElement;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dayElement.enabled ? onPressHandler(dayElement.date) : null,
      child: Container(
        width: 45,
        height: 84,
        decoration: BoxDecoration(
          color: _getDayBgColor(),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hexagon(
              width: 46,
              height: 46,
              borderRadius: 8,
              innerWidget: Container(
                color: _getHexagonBgColor(),
                alignment: Alignment.center,
                child: Text(
                  dayElement.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: _getDayTextColor(),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            Text(
              dayElement.day.toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: _getDateTextColor(),
                    fontSize: 12.0,
                  ),
            ),
            Text(
              dayElement.month,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: _getDateTextColor(),
                    fontSize: 12.0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
