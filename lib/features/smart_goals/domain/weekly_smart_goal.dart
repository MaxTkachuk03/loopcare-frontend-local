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

  String get title => smartGoal.title;

  String get categoryName => smartGoal.category.name;

  int get requiredCompletions => smartGoal.requiredCompletions;

  int get requiredDays => smartGoal.requiredDays;

  // TODO check what should be the logic  here
  // int get completions => progressLogs.map((e) => e.times);

  factory WeeklySmartGoal.fromJson(Map<String, dynamic> json) => _$WeeklySmartGoalFromJson(json);
}
