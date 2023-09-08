part of 'physical_activities_preferences_bloc.dart';

@freezed
class PhysicalActivitiesPreferencesEvent with _$PhysicalActivitiesPreferencesEvent {
  const factory PhysicalActivitiesPreferencesEvent.getPreferences() = _GetPreferences;

  const factory PhysicalActivitiesPreferencesEvent.setPreferences(PhysicalActivitiesPreferences data) =
      _SetPreferences;
}
