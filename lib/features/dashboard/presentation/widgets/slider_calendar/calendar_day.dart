import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class CalendarDay extends StatelessWidget {
  final Function(DateTime day) onPressHandler;
  final DateTime day;
  final bool isSelected;
  final bool isFutureDate;

  const CalendarDay({
    super.key,
    required this.onPressHandler,
    required this.day,
    required this.isSelected,
    required this.isFutureDate,
  });

  Color _getDayColor() {
    return isSelected
        ? AppColors.blueOffRegular
        : isFutureDate
            ? AppColors.blueDarker
            : AppColors.blueDarker;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressHandler(day),
      child: Container(
        width: 68,
        decoration: BoxDecoration(
          color: _getDayColor(),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.blueRegular,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText.w600(
              DateFormat.E('en_EN').format(day),
              style: context.textTheme.bodySmall!.copyWith(
                color: isSelected ? AppColors.white : AppColors.blueLighter,
                decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
                fontSize: isSelected ? 16.0 : 14.0,
              ),
            ),
            CustomText.w400(
              DateFormat.d('en_EN').format(day),
              style: context.textTheme.titleMedium!.copyWith(
                color: isSelected ? AppColors.white : AppColors.blueLighter,
                fontSize: isSelected ? 16.0 : 12.0,
              ),
            ),
            CustomText.w400(
              DateFormat.MMM('en_EN').format(day),
              style: context.textTheme.titleMedium!.copyWith(
                color: isSelected ? AppColors.white : AppColors.blueLighter,
                fontSize: isSelected ? 16.0 : 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
