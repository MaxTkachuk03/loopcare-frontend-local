import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_smart_goal.dart';

part 'weekly_goals_session.freezed.dart';
part 'weekly_goals_session.g.dart';

@freezed
class WeeklyGoalsSession with _$WeeklyGoalsSession {
  const WeeklyGoalsSession._();

  const factory WeeklyGoalsSession({
    int? id,
    DateTime? startedAt,
    DateTime? finishedAt,
    DateTime? lastReviewDate,
    WeeklySmartGoal? goal,
    bool? isActive,
  }) = _WeeklyGoalsSession;

  factory WeeklyGoalsSession.fromJson(Map<String, dynamic> json) =>
      _$WeeklyGoalsSessionFromJson(json);

  bool get sessionHasGoal => goal != null;

  bool get isWeeklySessionHasTimestamp => finishedAt != null && startedAt != null;

  bool get isWeeklySessionActive => isActive ?? false;

  bool get isWeeklySessionPeriodActive =>
      isWeeklySessionHasTimestamp ? (finishedAt!.isFuture || finishedAt!.isToday) : false;

  bool get hasActiveSession => isWeeklySessionActive && isWeeklySessionPeriodActive;

  bool get hasQuickReviewWeeklyGoals => !isWeeklySessionPeriodActive && hasReviewDelay;

  bool get hasReviewDelay =>
      isWeeklySessionHasTimestamp ? (lastReviewDate!.isFuture || lastReviewDate!.isToday) : false;

  int get daysLeft => finishedAt!.difference(DateTime.now().dateOnly).inDays;

  int get daysReviewLeft => lastReviewDate!.difference(DateTime.now().dateOnly).inDays;
}
