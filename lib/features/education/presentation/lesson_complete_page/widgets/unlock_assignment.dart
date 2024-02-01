import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';

class UnlockAssignment extends StatelessWidget {
  final DateTime completedAt;
  final VoidCallback onBtnPressed;

  const UnlockAssignment({super.key, required this.completedAt, required this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return FeatureUnlock(
      title: LocalizedTexts.assignmentAddedTitle.tr(),
      body: LocalizedTexts.assignmentAddedText.tr(
        namedArgs: {
          'date': completedAt.add(const Duration(days: 7)).dayWithMonthWithoutLeadingZero,
        },
      ),
      action: CustomOutlinedButton.blueSmall(
        onPressed: onBtnPressed,
        label: LocalizedTexts.startNow.tr(),
      ),
    );
  }
}
