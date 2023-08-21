part of 'topics_bloc.dart';

@freezed
class TopicsState with _$TopicsState {
  const factory TopicsState.initial(TopiscData data) = _Initial;

  const factory TopicsState.updated(TopiscData data) = _Updated;

  const factory TopicsState.loading(TopiscData data) = _Loading;

  const factory TopicsState.error(TopiscData data) = _Error;
}

@freezed
class TopiscData with _$TopiscData {
  const TopiscData._();

  const factory TopiscData({
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _TopiscData;
}
