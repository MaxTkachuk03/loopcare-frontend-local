part of 'topics_bloc.dart';

@freezed
class TopicsState with _$TopicsState {
  const TopicsState._();

  const factory TopicsState.initial(TopicsData data) = _Initial;

  const factory TopicsState.updated(TopicsData data) = _Updated;

  const factory TopicsState.loading(TopicsData data) = _Loading;

  const factory TopicsState.error(TopicsData data) = _Error;
}

@freezed
class TopicsData with _$TopicsData {
  const TopicsData._();

  const factory TopicsData({
    @Default({}) Map<int, Topic> topics,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _TopicsData;

  Topic? get thisWeekTopic => topics[DateTime.now().weekNumber];

  List<GroupSessionProgramEvent>? get thisWeekTopicProgram => thisWeekTopic?.groupSessionProgramEvents;

  String get thisWeekTopicName => topics[DateTime.now().weekNumber]?.topic ?? '';

  String get nextWeekTopicName => topics[DateTime.now().nextWeekNumber]?.topic ?? '';

  GroupSession? get signedGroupSession {
    // TODO hardcode for testing
    return thisWeekTopic?.groupSessions.first;
    // return thisWeekTopic?.groupSessions.firstWhereOrNull((s) => s.signed);
  }

  DateTime? get signedGroupSessionStartTime => signedGroupSession?.startDate;

  String? get signedGroupSessionToken => signedGroupSession?.signature;

  String? get signedGroupSessionPassword => signedGroupSession?.password;

  Duration get durationLeftToSessionStart {
    // TODO hardcode for testing
    // final sessionDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse("2023-08-24T22:12:00.000Z");
    final sessionDate = DateTime.now().add(const Duration(seconds: 10));

    return sessionDate.difference(DateTime.now());
    // return signedGroupSessionStartTime?.difference(DateTime.now());
  }
}
