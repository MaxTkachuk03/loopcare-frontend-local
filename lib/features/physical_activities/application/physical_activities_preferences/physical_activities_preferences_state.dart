part of 'physical_activities_preferences_bloc.dart';

@freezed
class PhysicalActivitiesPreferencesState with _$PhysicalActivitiesPreferencesState {
  const factory PhysicalActivitiesPreferencesState.initial(PhysicalActivitiesPreferencesData data) = Initial;

  const factory PhysicalActivitiesPreferencesState.loading(PhysicalActivitiesPreferencesData data) = Loading;

  const factory PhysicalActivitiesPreferencesState.preferencesLoaded(PhysicalActivitiesPreferencesData data) =
      PreferencesLoaded;

  const factory PhysicalActivitiesPreferencesState.error(PhysicalActivitiesPreferencesData data) = Error;

  const PhysicalActivitiesPreferencesState._();
}

@freezed
class PhysicalActivitiesPreferencesData with _$PhysicalActivitiesPreferencesData {
  const PhysicalActivitiesPreferencesData._();

  const factory PhysicalActivitiesPreferencesData({
    @Default('') String trainingFrequency,
    @Default('') String trainingTargets,
    @Default(false) bool flexible,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _PhysicalActivitiesPreferencesData;
}
