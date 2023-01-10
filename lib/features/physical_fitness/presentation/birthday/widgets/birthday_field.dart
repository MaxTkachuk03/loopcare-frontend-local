import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/birthday/widgets/birthdate_picker.dart';

class BirthdayField extends StatefulWidget {
  final void Function() onNextPressed;

  const BirthdayField({
    Key? key,
    required this.onNextPressed,
  }) : super(key: key);

  @override
  State<BirthdayField> createState() => _BirthdayFieldState();
}

class _BirthdayFieldState extends State<BirthdayField> {
  late DateTime value = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Text(
                DateFormat('d MMMM yyyy').format(value),
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontFamily: ThemeConstants.bitterFontFamily,
                      fontSize: ThemeConstants.fontSize38,
                    ),
              ),
              const SizedBox(height: 120.0),
              ElevatedButton(
                onPressed: widget.onNextPressed,
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.orangeDark),
                    ),
                child: Text(
                  LocalizedTexts.next.tr(),
                ),
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
        BirthDatePicker(
          value: value,
          selectedDate: selectedDate,
        ),
      ],
    );
  }

  void selectedDate(DateTime selectedDate) {
    setState(() => value = selectedDate);
  }
}
