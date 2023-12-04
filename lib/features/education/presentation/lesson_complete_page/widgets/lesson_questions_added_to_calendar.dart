import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/app_unlock_block.dart';

class LessonQuestionsAddedToCalendar extends StatelessWidget {
  final DateTime completedAt;
  final VoidCallback onBtnPressed;

  const LessonQuestionsAddedToCalendar({
    Key? key,
    required this.completedAt,
    required this.onBtnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        AppUnlockBlock(
          title: LocalizedTexts.assignmentAddedTitle.translation.capitalize(),
          text: LocalizedTexts.assignmentAddedText.translateWithNamedArgs({
            'date': completedAt.add(const Duration(days: 7)).dayWithMonthWithoutLeadingZero,
          }).capitalize(),
          onBtnPressed: onBtnPressed,
          btnText: LocalizedTexts.startNow.translation,
        ),
      ],
    );
  }
}
