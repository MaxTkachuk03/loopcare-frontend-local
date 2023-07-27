part of 'group_preferences_bloc.dart';

@freezed
class GroupPreferencesEvent with _$GroupPreferencesEvent {
  const factory GroupPreferencesEvent.setGenderPreferences(GenderPreferences gender) = SetGenderPreferences;

  const factory GroupPreferencesEvent.setTimezone(String timezone) = SetTimezone;

  const factory GroupPreferencesEvent.setNickname(String nickname) = SetNickname;
}
