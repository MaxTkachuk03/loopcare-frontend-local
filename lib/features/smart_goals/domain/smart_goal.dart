import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_progress.dart';

part 'smart_goal.freezed.dart';
part 'smart_goal.g.dart';

@freezed
class SmartGoal with _$SmartGoal {
  const SmartGoal._();

  const factory SmartGoal({
    required int id,
    required SmartGoalCategory category,
    @Default('') String title,
    @Default('') String titleShort,
    @Default('') String funFact,
    @Default(0) int requiredCompletions,
    @Default(0) int requiredDays,
  }) = _SmartGoal;

  factory SmartGoal.fromJson(Map<String, dynamic> json) => _$SmartGoalFromJson(json);
}
