part of 'smart_goals_bloc.dart';

@freezed
class SmartGoalsState with _$SmartGoalsState {
  const factory SmartGoalsState.initial(SmartGoalsStateData data) = SmartGoalsStateInitial;

  const factory SmartGoalsState.loading(SmartGoalsStateData data) = SmartGoalsStateLoading;

  const factory SmartGoalsState.goalsLoaded(SmartGoalsStateData data) = SmartGoalsStateLoaded;

  const factory SmartGoalsState.error(SmartGoalsStateData data) = SmartGoalsStateError;

  const factory SmartGoalsState.goalsCategoriesLoading(SmartGoalsStateData data) = GoalsCategoriesLoading;

  const factory SmartGoalsState.goalsCategoriesLoaded(SmartGoalsStateData data) = GoalsCategoriesLoaded;

  const factory SmartGoalsState.goalsCategoriesError(SmartGoalsStateData data) = GoalsCategoriesError;
}

@freezed
class SmartGoalsStateData with _$SmartGoalsStateData {
  const SmartGoalsStateData._();

  const factory SmartGoalsStateData({
    @Default(false) bool isLoading,
    RequestError? error,
    @Default([]) List<SmartGoal> goals,
    @Default([]) List<SmartGoalCategory> goalsCategories,
  }) = _SmartGoalsStateData;

  bool get noGoalsSelected => goals.isEmpty;
}
