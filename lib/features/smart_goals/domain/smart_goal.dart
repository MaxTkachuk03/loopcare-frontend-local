import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';

part 'smart_goal.freezed.dart';
part 'smart_goal.g.dart';

@freezed
class SmartGoal with _$SmartGoal {
  const SmartGoal._();

  const factory SmartGoal({
    required int id,
    required int externalId,
    required SmartGoalCategory category,
    @Default('') String title,
    @Default('') String description,
    @Default('') String shortTitle,
    @Default('') String funFact,
    @Default(0) int requiredCompletionDays,
    @Default(0) int lengthInDays,
    @Default([]) List<int> relatedExternalGoalIds,
  }) = _SmartGoal;

  factory SmartGoal.fromJson(Map<String, dynamic> json) => _$SmartGoalFromJson(json);
}
