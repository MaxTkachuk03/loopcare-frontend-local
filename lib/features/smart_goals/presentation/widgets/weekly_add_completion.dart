import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/goal_progress_controller.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/progress_smart_goal_log.dart';
import 'package:loopcare_frontend/features/smart_goals/presentation/widgets/weekly_times_corrector.dart';

class WeeklyAddCompletion extends StatelessWidget {
  final GoalProgressController controller;

  const WeeklyAddCompletion({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressSmartGoalLog?>(
      valueListenable: controller.selectedValueNotifier,
      builder: (context, log, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText.w600(
              LocalizedTexts.weeklyAddCompletions.tr(),
              textAlign: TextAlign.start,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 4.0),
            CustomText.w400(
              controller.getTimesSelectedDay(),
              textAlign: TextAlign.start,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8.0),
            WeeklyTimesCorrector(
              onIncrease: controller.onIncrease,
              onDecreased: (log?.times ?? -1) > 0 ? controller.onDecrease : null,
            ),
          ],
        );
      },
    );
  }
}
