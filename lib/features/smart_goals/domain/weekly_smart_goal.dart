import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_progress.dart';

part 'weekly_smart_goal.freezed.dart';
part 'weekly_smart_goal.g.dart';

@freezed
class WeeklySmartGoal with _$WeeklySmartGoal {
  const WeeklySmartGoal._();

  const factory WeeklySmartGoal({
    required int id,
    required SmartGoal smartGoal,
    int? difficulty,
    bool? isTryAgain,
    List<SmartGoalProgress>? progressLogs,
  }) = _WeeklySmartGoal;

  factory WeeklySmartGoal.fromJson(Map<String, dynamic> json) => _$WeeklySmartGoalFromJson(json);
}
