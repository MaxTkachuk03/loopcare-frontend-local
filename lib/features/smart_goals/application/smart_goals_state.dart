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
}

@freezed
class SmartGoalsStateData with _$SmartGoalsStateData {
  const SmartGoalsStateData._();

  const factory SmartGoalsStateData({
    @Default(false) bool isLoading,
    RequestError? error,
    @Default([]) List<SmartGoal> goals,
    @Default([]) List<SmartGoal> selectedGoals,
    @Default([]) List<ProgressSmartGoalLog> logs,
    WeeklyGoalsSession? weeklyGoalsSession,
  }) = _SmartGoalsStateData;

  bool get cantAddGoal => selectedGoals.length >= 2;

  bool get noGoalsSelected => goals.isEmpty;

  bool get hasWeeklyGoals => selectedGoals.isNotEmpty || weeklyGoals.isNotEmpty;

  bool get hasSelectedGoals => selectedGoals.isNotEmpty;

  bool get isWeeklySessionHasTimestamp =>
      weeklyGoalsSession?.finishedAt != null && weeklyGoalsSession?.startedAt != null;

  bool get isWeeklySessionActive => weeklyGoalsSession?.isActive ?? false;

  bool get isWeeklySessionPeriodActive =>
      isWeeklySessionHasTimestamp ? weeklyGoalsSession!.finishedAt!.isFuture : false;

  bool get hasActiveSession => isWeeklySessionActive && isWeeklySessionPeriodActive;

  bool get hasFinishedSession => hasReviewDelay && !isWeeklySessionActive && !isWeeklySessionPeriodActive;

  bool get hasQuickReviewWeeklyGoals => !isWeeklySessionPeriodActive && hasReviewDelay;

  bool get hasReviewDelay => isWeeklySessionHasTimestamp ? daysReview <= sessionReviewDelay : false;

  int get daysLeft => weeklyGoalsSession!.finishedAt!.difference(DateTime.now().getDateOnly).inDays;

  int get daysUpper => DateTime.now().difference(weeklyGoalsSession!.startedAt!).inDays;

  int get daysReview => DateTime.now().difference(weeklyGoalsSession!.finishedAt!).inDays;

  List<WeeklySmartGoal> get weeklyGoals => weeklyGoalsSession?.goals ?? [];

  WeeklySmartGoal? get firstGoalForReview {
    final goals = weeklyGoals;

    if (goals.isEmpty) return null;

    return weeklyGoals.first;
  }

  WeeklySmartGoal? getNextGoalForReview(WeeklySmartGoal currentGoal) {
    final goals = weeklyGoalsSession?.goals;

    if (goals == null) return null;

    final index = goals.indexWhere((g) => g.id == currentGoal.id);

    final nextGoalIndex = index + 1;

    if (index == -1 || nextGoalIndex > goals.length - 1) return null;

    return goals[nextGoalIndex];
  }

  bool isLastGoalInSession(WeeklySmartGoal goal) {
    final goals = weeklyGoals;

    if (goals.isEmpty || goals.length == 1) return true;

    return goal.id == goals.last.id;
  }
}
