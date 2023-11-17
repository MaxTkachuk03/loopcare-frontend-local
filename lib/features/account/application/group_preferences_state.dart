part of 'group_preferences_bloc.dart';

@freezed
class GroupPreferencesState with _$GroupPreferencesState {
  const factory GroupPreferencesState.initial(GroupPreferencesData data) = _Initial;

  const factory GroupPreferencesState.updated(GroupPreferencesData data) = GroupPreferencesUpdated;

  const factory GroupPreferencesState.loading(GroupPreferencesData data) = GroupPreferencesLoading;

  const factory GroupPreferencesState.error(GroupPreferencesData data) = _Error;
}

@freezed
class GroupPreferencesData with _$GroupPreferencesData {
  const GroupPreferencesData._();

  const factory GroupPreferencesData({
    YesNoAnswer? wouldLikeJoinGroup,
    String? nickname,
    String? timezone,
    GenderPreferences? genderPreferences,
    @Default(false) bool isLoading,
    @Default(GroupPrefsMode.singlePage) GroupPrefsMode groupPrefsMode,
    RequestError? error,
  }) = _GroupPreferencesData;
}
