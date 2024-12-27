part of 'nutrition_intake_bloc.dart';

@freezed
class NutritionIntakeState with _$NutritionIntakeState {
  const factory NutritionIntakeState.initial(NutritionIntakeStateData data) =
      NutritionIntakeStateInitial;

  const factory NutritionIntakeState.loading(NutritionIntakeStateData data) =
      NutritionIntakeStateLoading;

  const factory NutritionIntakeState.error(NutritionIntakeStateData data) =
      NutritionIntakeStateError;

  const factory NutritionIntakeState.loaded(NutritionIntakeStateData data) =
      NutritionIntakeStateLoaded;

  const factory NutritionIntakeState.completeDay(
      NutritionIntakeStateData data) = NutritionIntakeStateCloseDay;

  const factory NutritionIntakeState.finishLesson(
      NutritionIntakeStateData data) = NutritionIntakeStateFinishLesson;
}

@freezed
class NutritionIntakeStateData with _$NutritionIntakeStateData {
  const NutritionIntakeStateData._();

  const factory NutritionIntakeStateData({
    @Default(false) bool isDayClosed,
    @Default([]) List<NutritionIntakeGoalProgress> progress,
    @Default(null) NutritionIntakeGoalProgress? doneLessons,
    @Default(false) bool isLoading,
    @Default('') String dateTime,
    @Default(0) int iLessonId,
    RequestError? error,
  }) = _NutritionIntakeStateData;
}
