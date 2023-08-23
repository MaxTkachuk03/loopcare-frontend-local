part of 'topics_bloc.dart';

@freezed
class TopicsState with _$TopicsState {
  const TopicsState._();

  const factory TopicsState.initial(TopiscData data) = _Initial;

  const factory TopicsState.updated(TopiscData data) = _Updated;

  const factory TopicsState.loading(TopiscData data) = _Loading;

  const factory TopicsState.error(TopiscData data) = _Error;

  String get thisWeekTopicName {
    return maybeWhen(
      orElse: () => '',
      updated: (state) => state.topics[DateTime.now().weekNumber]?.topic ?? '',
    );
  }

  String get nextWeekTopicName {
    return maybeWhen(
      orElse: () => '',
      updated: (state) => state.topics[DateTime.now().nextWeekNumber]?.topic ?? '',
    );
  }
}

@freezed
class TopiscData with _$TopiscData {
  const TopiscData._();

  const factory TopiscData({
    @Default({}) Map<int, Topic> topics,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _TopiscData;
}
