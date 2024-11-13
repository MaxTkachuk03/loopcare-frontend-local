import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_goal_progress_log.freezed.dart';
part 'weekly_goal_progress_log.g.dart';

@freezed
class WeeklyGoalProgressLog with _$WeeklyGoalProgressLog {
  const WeeklyGoalProgressLog._();

  const factory WeeklyGoalProgressLog({
    required int id,
    required DateTime date,
    required int times,
  }) = _WeeklyGoalProgressLog;

  factory WeeklyGoalProgressLog.fromJson(Map<String, dynamic> json) =>
      _$WeeklyGoalProgressLogFromJson(json);
}
