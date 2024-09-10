part of 'physical_activities_preferences_bloc.dart';

@freezed
class PhysicalActivitiesPreferencesEvent with _$PhysicalActivitiesPreferencesEvent {
  const factory PhysicalActivitiesPreferencesEvent.init() = _Init;
  const factory PhysicalActivitiesPreferencesEvent.getPreferences() = _GetPreferences;

  const factory PhysicalActivitiesPreferencesEvent.savePreferences() = _SavePreferences;

  const factory PhysicalActivitiesPreferencesEvent.setFrequency(PhysicalActivitiesFrequency data) =
      _SetFrequency;

  const factory PhysicalActivitiesPreferencesEvent.setTargets(PhysicalActivitiesType data) =
      _SetTargets;

  const factory PhysicalActivitiesPreferencesEvent.setFlexible(bool data) = _SetFlexible;
}
