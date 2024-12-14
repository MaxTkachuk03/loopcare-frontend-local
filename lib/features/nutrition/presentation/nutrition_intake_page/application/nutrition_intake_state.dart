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

  const factory NutritionIntakeState.closeDay(NutritionIntakeStateData data) =
      NutritionIntakeStateCloseDay;
}

@freezed
class NutritionIntakeStateData with _$NutritionIntakeStateData {
  const NutritionIntakeStateData._();

  const factory NutritionIntakeStateData({
    @Default(false) bool isDayClosed,
    @Default([]) List<NutritionIntakeDoneLessons> progress,
    @Default(null) NutritionIntakeDoneLessons? doneLessons,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _NutritionIntakeStateData;
}
