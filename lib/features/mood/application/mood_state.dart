part of 'mood_bloc.dart';

@freezed
class MoodState with _$MoodState {
  const factory MoodState.initial(MoodStateData data) = MoodStateInitial;

  const factory MoodState.loading(MoodStateData data) = MoodStateLoading;

  const factory MoodState.error(MoodStateData data) = MoodStateError;

  const factory MoodState.updated(MoodStateData data) = MoodStateUpdated;
}

@freezed
class MoodStateData with _$MoodStateData {
  const MoodStateData._();

  const factory MoodStateData({
    @Default({}) Map<String, List<Mood>> moods,
    @Default(false) bool isLoading,
    @Default(null) RequestError? error,
  }) = _MoodStateData;

  String? get errorMessage => error?.maybeMap(notFound: (s) => s.error.message, orElse: () => null);

  List<Mood> getSelectedDayMoods(String date) => moods[date] ?? [];
}
