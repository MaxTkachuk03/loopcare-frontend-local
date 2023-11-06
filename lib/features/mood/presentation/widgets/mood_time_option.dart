import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class MoodTimeOption extends StatefulWidget {
  final void Function(DateTime value) onChange;
  final DateTime initialValue;

  const MoodTimeOption({super.key, required this.onChange, required this.initialValue});

  @override
  State<MoodTimeOption> createState() => _MoodTimeOptionState();
}

class _MoodTimeOptionState extends State<MoodTimeOption> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              color: AppColors.black,
              fontSize: ThemeConstants.fontSize18,
            ),
          ),
        ),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          initialDateTime: widget.initialValue,
          maximumDate: DateTime.now(),
          onDateTimeChanged: widget.onChange,
        ),
      ),
    );
  }
}
