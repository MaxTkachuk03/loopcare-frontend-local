part of 'smart_goals_categories_bloc.dart';

@freezed
class SmartGoalsCategoriesState with _$SmartGoalsCategoriesState {
  const factory SmartGoalsCategoriesState.initial(SmartGoalsCategoriesStateData data) =
      SmartGoalsCategoriesStateInitial;

  const factory SmartGoalsCategoriesState.goalsCategoriesLoading(
      SmartGoalsCategoriesStateData data) = SmartGoalsCategoriesStateLoading;

  const factory SmartGoalsCategoriesState.goalsCategoriesLoaded(
      SmartGoalsCategoriesStateData data) = SmartGoalsCategoriesStateLoaded;

  const factory SmartGoalsCategoriesState.goalsCategoriesError(SmartGoalsCategoriesStateData data) =
      SmartGoalsCategoriesStateError;
}

@freezed
class SmartGoalsCategoriesStateData with _$SmartGoalsCategoriesStateData {
  const SmartGoalsCategoriesStateData._();

  const factory SmartGoalsCategoriesStateData({
    @Default(false) bool isLoading,
    RequestError? error,
    @Default([]) List<SmartGoalCategory> goalsCategories,
  }) = _SmartGoalsCategoriesStateData;
}
