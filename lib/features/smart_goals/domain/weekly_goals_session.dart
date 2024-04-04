import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';

part 'weekly_goals_session.freezed.dart';
part 'weekly_goals_session.g.dart';

@freezed
class WeeklyGoalsSession with _$WeeklyGoalsSession {
  const WeeklyGoalsSession._();

  const factory WeeklyGoalsSession({
    required String startedAt,
    required String finishedAt,
    required List<SmartGoal> goals,
    required bool isActive,
  }) = _WeeklyGoalsSession;

  factory WeeklyGoalsSession.fromJson(Map<String, dynamic> json) => _$WeeklyGoalsSessionFromJson(json);
}
