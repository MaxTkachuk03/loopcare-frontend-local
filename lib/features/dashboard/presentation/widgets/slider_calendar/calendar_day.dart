import 'package:intl/intl.dart';
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

  Color get _dayColor => isSelected ? AppColors.blueOffRegular : AppColors.blueDarker;

  Color get _textColor => isSelected ? AppColors.white : AppColors.blueLighter;

  double get _width => isSelected ? 81.0 : 68.0;

  double get _topPadding => isSelected ? 0.0 : 6.0;

  double get _fontSize => isSelected ? 16.0 : 14.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressHandler(day),
      child: Container(
        width: _width,
        margin: EdgeInsets.fromLTRB(0.5, _topPadding, 0.5, 0),
        decoration: BoxDecoration(
          color: _dayColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText.w600(
              DateFormat.E('en_EN').format(day),
              style: context.textTheme.bodySmall!.copyWith(
                color: _textColor,
                fontSize: _fontSize,
              ),
            ),
            CustomText.w400(
              DateFormat.d('en_EN').format(day),
              style: context.textTheme.titleMedium!.copyWith(
                color: _textColor,
                fontSize: _fontSize,
              ),
            ),
            CustomText.w400(
              DateFormat.MMM('en_EN').format(day),
              style: context.textTheme.titleMedium!.copyWith(
                color: _textColor,
                fontSize: _fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
