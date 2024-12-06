part of 'nutrution_intake_bloc.dart';

@freezed
class NutrutionIntakeState with _$NutrutionIntakeState {
  const factory NutrutionIntakeState.initial(NutrutionIntakeStateData data) =
      NutrutionIntakeStateInitial;

  const factory NutrutionIntakeState.loading(NutrutionIntakeStateData data) =
      NutrutionIntakeStateLoading;

  const factory NutrutionIntakeState.error(NutrutionIntakeStateData data) =
      NutrutionIntakeStateError;

  const factory NutrutionIntakeState.loaded(NutrutionIntakeStateData data) =
      NutrutionIntakeStateLoaded;

  const factory NutrutionIntakeState.closeDay(NutrutionIntakeStateData data) =
      NutrutionIntakeStateCloseDay;
}

@freezed
class NutrutionIntakeStateData with _$NutrutionIntakeStateData {
  const NutrutionIntakeStateData._();

  const factory NutrutionIntakeStateData({
    @Default(false) bool isDayClosed,
    @Default([]) List<NitritionIntakeDoneLessons> progress,
    @Default(null) NitritionIntakeDoneLessons? doneLessons,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _NutrutionIntakeStateData;
}
