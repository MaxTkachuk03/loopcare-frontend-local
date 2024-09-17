import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/feature_unlock.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

// todo: check if this is still needed
class UnlockAssignment extends StatelessWidget {
  final DateTime completedAt;
  final VoidCallback onBtnPressed;

  const UnlockAssignment({super.key, required this.completedAt, required this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return FeatureUnlock(
      title: LocalizedTexts.assignmentAddedTitle.tr(),
      body: LocalizedTexts.assignmentAddedText.tr(
        {
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
