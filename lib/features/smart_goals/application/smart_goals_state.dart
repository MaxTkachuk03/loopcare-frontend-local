part of 'smart_goals_bloc.dart';

@freezed
class SmartGoalsState with _$SmartGoalsState {
  const factory SmartGoalsState.initial(SmartGoalsStateData data) = SmartGoalsStateInitial;

  const factory SmartGoalsState.loading(SmartGoalsStateData data) = SmartGoalsStateLoading;

  const factory SmartGoalsState.goalsLoaded(SmartGoalsStateData data) = SmartGoalsStateLoaded;

  const factory SmartGoalsState.error(SmartGoalsStateData data) = SmartGoalsStateError;

  const factory SmartGoalsState.errorSaveGoals(SmartGoalsStateData data) =
      SmartGoalsStateErrorSaveGoals;

  const factory SmartGoalsState.weeklySessionSaved(SmartGoalsStateData data) =
      SmartGoalsStateWeeklySessionSaved;

  const factory SmartGoalsState.gotWeeklySession(SmartGoalsStateData data) =
      GotSmartGoalsStateWeeklySession;

  const factory SmartGoalsState.errorAddingReview(SmartGoalsStateData data) =
      GotSmartGoalsStateErrorAddingReview;

  const factory SmartGoalsState.reviewAdded(SmartGoalsStateData data) =
      GotSmartGoalsStateReviewAdded;

  const factory SmartGoalsState.progressConfirmed(SmartGoalsStateData data) = ProgressConfirmed;

  const factory SmartGoalsState.progressReset(SmartGoalsStateData data) = ProgressReset;

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
    @Default([]) List<WeeklyGoalsSession> weeklyGoalsSessions,
    DateTime? selectedDate,
    CancelGoalReason? reason,
  }) = _SmartGoalsStateData;

  bool get hasGoalActiveSessions => weeklyGoalsSessions.isNotEmpty;

  WeeklyGoalsSession? getWeeklySession(int sessionId) =>
      weeklyGoalsSessions.firstWhereOrNull((session) => session.id == sessionId);

  bool isDateHasActiveSession(DateTime selectedDay) =>
      weeklyGoalsSessions.any((session) => _isDateHasActiveGoal(selectedDay, session));

  bool _isDateHasActiveGoal(DateTime selectedDay, WeeklyGoalsSession session) {
    final startDay = session.startedAt;
    if (startDay == null) {
      return false;
    }
    return ((startDay.dateOnly.isBefore(selectedDay.dateOnly)) ||
        startDay.dateOnly == selectedDay.dateOnly);
  }

  bool get emptySessionState =>
      weeklyGoalsSessions.every((session) => !session.sessionHasGoal || !session.hasReviewDelay);

  bool goalWasAdded(List<int> relatedExternalIds, int externalId) =>
      weeklyGoalsSessions.any((session) {
        final id = session.goal?.smartGoal.externalId;
        return relatedExternalIds.contains(id) || id == externalId;
      });
  String get errorKey => error?.message ?? LocalizedTexts.errorSomethingWentWrong;
}
