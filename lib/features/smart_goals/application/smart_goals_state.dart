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
}

@freezed
class SmartGoalsStateData with _$SmartGoalsStateData {
  const SmartGoalsStateData._();

  const factory SmartGoalsStateData({
    @Default(false) bool isLoading,
    RequestError? error,
    @Default([]) List<SmartGoal> goals,
    @Default([]) List<SmartGoal> selectedGoals,
    WeeklyGoalsSession? weeklyGoalsSession,
  }) = _SmartGoalsStateData;

  bool get cantAddGoal => selectedGoals.length >= 2;

  bool get noGoalsSelected => goals.isEmpty;

  bool get hasWeeklyGoals => selectedGoals.isNotEmpty || weeklyGoals.isNotEmpty;

  List<SmartGoal> get weeklyGoals => weeklyGoalsSession?.goals ?? [];
}
