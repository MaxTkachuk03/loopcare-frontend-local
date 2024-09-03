import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

enum CancelGoalReason {
  notLike,
  challenging,
  missing,
  habit,
  specific,
}

extension GoalCancelReasonX on CancelGoalReason {
  String get label {
    switch (this) {
      case CancelGoalReason.notLike:
        return LocalizedTexts.smartGoalsReasonGoalNotLike.tr().capitalize();
      case CancelGoalReason.challenging:
        return LocalizedTexts.smartGoalsReasonGoalChallenging.tr().capitalize();
      case CancelGoalReason.missing:
        return LocalizedTexts.smartGoalsReasonGoalMissing.tr().capitalize();
      case CancelGoalReason.habit:
        return LocalizedTexts.smartGoalsReasonGoalHabit.tr().capitalize();
      case CancelGoalReason.specific:
        return LocalizedTexts.smartGoalsReasonGoalSpecific.tr().capitalize();
    }
  }
}
