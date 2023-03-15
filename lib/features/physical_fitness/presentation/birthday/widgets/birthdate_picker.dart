import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class BirthDatePicker extends StatelessWidget {
  final DateTime value;
  final void Function(DateTime selected) selectedDate;

  const BirthDatePicker({
    Key? key,
    required this.value,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l = Intl.getCurrentLocale();
    return SizedBox(
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
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (dateTime) => selectedDate(dateTime),
            backgroundColor: AppColors.datePickerBg,
            dateOrder: Intl.getCurrentLocale() == 'en_US'
                ? DatePickerDateOrder.mdy
                : DatePickerDateOrder.dmy),
      ),
    );
  }
}
