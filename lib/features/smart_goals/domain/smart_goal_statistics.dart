import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';

part 'smart_goal_statistics.freezed.dart';
part 'smart_goal_statistics.g.dart';

@freezed
class SmartGoalStatistics with _$SmartGoalStatistics {
  const SmartGoalStatistics._();

  const factory SmartGoalStatistics({
    required SmartGoalCategory category,
    @Default(0) int completed,
    @Default(0) int total,
  }) = _SmartGoalStatistics;

  factory SmartGoalStatistics.fromJson(Map<String, dynamic> json) => _$SmartGoalStatisticsFromJson(json);
}
