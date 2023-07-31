part of 'group_preferences_bloc.dart';

@freezed
class GroupPreferencesState with _$GroupPreferencesState {
  const factory GroupPreferencesState.initial(GroupPreferencesData data) = _Initial;

  const factory GroupPreferencesState.updated(GroupPreferencesData data) = _Updated;

  const factory GroupPreferencesState.loading(GroupPreferencesData data) = _Loading;

  const factory GroupPreferencesState.error(GroupPreferencesData data) = _Error;
}

@freezed
class GroupPreferencesData with _$GroupPreferencesData {
  const GroupPreferencesData._();

  const factory GroupPreferencesData({
    @Default(YesNoAnswer.no) YesNoAnswer wouldLikeJoinGroup,
    @Default('') String nickname,
    @Default('') String timezone,
    @Default(GenderPreferences.noPreference) GenderPreferences genderPreferences,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _GroupPreferencesData;
}
