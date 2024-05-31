part of 'smart_goals_bloc.dart';

@freezed
class SmartGoalsState with _$SmartGoalsState {
  const factory SmartGoalsState.initial(SmartGoalsStateData data) = SmartGoalsStateInitial;

  const factory SmartGoalsState.loading(SmartGoalsStateData data) = SmartGoalsStateLoading;

  const factory SmartGoalsState.goalsLoaded(SmartGoalsStateData data) = SmartGoalsStateLoaded;

  const factory SmartGoalsState.error(SmartGoalsStateData data) = SmartGoalsStateError;

  const factory SmartGoalsState.errorSaveGoals(SmartGoalsStateData data) = SmartGoalsStateErrorSaveGoals;

  const factory SmartGoalsState.weeklySessionSaved(SmartGoalsStateData data) = SmartGoalsStateWeeklySessionSaved;

  const factory SmartGoalsState.gotWeeklySession(SmartGoalsStateData data) = GotSmartGoalsStateWeeklySession;

  const factory SmartGoalsState.errorAddingReview(SmartGoalsStateData data) = GotSmartGoalsStateErrorAddingReview;

  const factory SmartGoalsState.reviewAdded(SmartGoalsStateData data) = GotSmartGoalsStateReviewAdded;

  const factory SmartGoalsState.updatedLoggerTimes(SmartGoalsStateData data) = UpdatedLoggerTimes;

  const factory SmartGoalsState.resetedLoggerTimes(SmartGoalsStateData data) = ResetedLoggerTimes;

  const factory SmartGoalsState.progressConfirmed(SmartGoalsStateData data) = ProgressConfirmed;

  const factory SmartGoalsState.sessionDeleted(SmartGoalsStateData data) = SessionDeleted;
}

@freezed
class SmartGoalsStateData with _$SmartGoalsStateData {
  const SmartGoalsStateData._();

  const factory SmartGoalsStateData({
    @Default(false) bool isLoading,
    RequestError? error,
    @Default([]) List<SmartGoal> goals,
    @Default([]) List<ProgressSmartGoalLog> logs,
    WeeklyGoalsSession? weeklyGoalsSession,
    DateTime? selectedDate,
    CancelGoalReason? reason,
  }) = _SmartGoalsStateData;

  bool get hasWeeklyGoals => weeklyGoals.isNotEmpty;

  bool get isWeeklySessionHasTimestamp =>
      weeklyGoalsSession?.finishedAt != null && weeklyGoalsSession?.startedAt != null;

  bool get isWeeklySessionActive => weeklyGoalsSession?.isActive ?? false;

  bool get isWeeklySessionPeriodActive => isWeeklySessionHasTimestamp
      ? (weeklyGoalsSession!.finishedAt!.isFuture || weeklyGoalsSession!.finishedAt!.isToday)
      : false;

  bool get hasActiveSession => isWeeklySessionActive && isWeeklySessionPeriodActive;

  bool get hasQuickReviewWeeklyGoals => !isWeeklySessionPeriodActive && hasReviewDelay;

  bool get hasReviewDelay => isWeeklySessionHasTimestamp
      ? (weeklyGoalsSession!.lastReviewDate!.isFuture || weeklyGoalsSession!.lastReviewDate!.isToday)
      : false;

  int get daysLeft => weeklyGoalsSession!.finishedAt!.difference(DateTime.now().dateOnly).inDays;

  int get daysReviewLeft => weeklyGoalsSession!.lastReviewDate!.difference(DateTime.now().dateOnly).inDays;

  List<WeeklySmartGoal> get weeklyGoals => weeklyGoalsSession?.goals ?? [];

  bool get hasGoalActiveSessions => weeklyGoals.isNotEmpty;

  bool isDateHasActiveSession(DateTime selectedDay) {
    final startDay = weeklyGoalsSession?.startedAt;
    if (startDay == null) {
      return false;
    }
    return ((startDay.dateOnly.isBefore(selectedDay.dateOnly)) || startDay.dateOnly == selectedDay.dateOnly);
  }
}
