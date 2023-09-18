part of 'physical_activities_preferences_bloc.dart';

@freezed
class PhysicalActivitiesPreferencesState with _$PhysicalActivitiesPreferencesState {
  const factory PhysicalActivitiesPreferencesState.initial(PhysicalActivitiesPreferencesData data) = Initial;

  const factory PhysicalActivitiesPreferencesState.loading(PhysicalActivitiesPreferencesData data) = Loading;

  const factory PhysicalActivitiesPreferencesState.saving(PhysicalActivitiesPreferencesData data) = Saving;

  const factory PhysicalActivitiesPreferencesState.preferencesLoaded(PhysicalActivitiesPreferencesData data) =
      PreferencesLoaded;

  const factory PhysicalActivitiesPreferencesState.error(PhysicalActivitiesPreferencesData data) = Error;

  const PhysicalActivitiesPreferencesState._();
}

@freezed
class PhysicalActivitiesPreferencesData with _$PhysicalActivitiesPreferencesData {
  const PhysicalActivitiesPreferencesData._();

  const factory PhysicalActivitiesPreferencesData({
    PhysicalActivitiesFrequency? trainingFrequency,
    PhysicalActivitiesType? trainingTargets,
    bool? flexible,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _PhysicalActivitiesPreferencesData;

  bool get isFrequencySet {
    return trainingFrequency != null;
  }

  bool get isTargetsSet {
    return trainingTargets != null;
  }

  bool get needActivitiesType {
    return trainingFrequency != PhysicalActivitiesFrequency.notAble;
  }

  bool get needFlexibility {
    return trainingFrequency != PhysicalActivitiesFrequency.oneTime &&
        trainingFrequency != PhysicalActivitiesFrequency.twoTimes;
  }

  PhysicalActivitiesFrequency? get currentTrainingFrequency => trainingFrequency;

  PhysicalActivitiesType? get currentTrainingTargets => trainingTargets;
}
