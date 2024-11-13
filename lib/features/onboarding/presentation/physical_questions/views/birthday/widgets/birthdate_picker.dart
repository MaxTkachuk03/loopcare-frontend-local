import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class BirthDatePicker extends StatelessWidget {
  final DateTime value;
  final void Function(DateTime selected) selectedDate;

  const BirthDatePicker({super.key, required this.value, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.datePickerBg,
      height: 262,
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: AppColors.datePickerText,
              fontSize: ThemeConstants.fontSize18,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: value,
          onDateTimeChanged: (dateTime) => selectedDate(dateTime),
          backgroundColor: AppColors.datePickerBg,
        ),
      ),
    );
  }
}
