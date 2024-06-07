import 'package:easy_localization/easy_localization.dart';
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
        return LocalizedTexts.reasonGoalNotLike.tr().capitalize();
      case CancelGoalReason.challenging:
        return LocalizedTexts.reasonGoalChallenging.tr().capitalize();
      case CancelGoalReason.missing:
        return LocalizedTexts.reasonGoalMissing.tr().capitalize();
      case CancelGoalReason.habit:
        return LocalizedTexts.reasonGoalHabit.tr().capitalize();
      case CancelGoalReason.specific:
        return LocalizedTexts.reasonGoalSpecific.tr().capitalize();
    }
  }
}
