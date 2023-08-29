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

  GroupSession? get signedGroupSession => thisWeekTopic?.groupSessions.firstWhereOrNull((s) => s.signed);

  DateTime? get signedGroupSessionStartTime => signedGroupSession?.startDate;

  String? get signedGroupSessionToken => signedGroupSession?.signature;

  String? get signedGroupSessionPassword => signedGroupSession?.password;

  List<GroupSessionProgramEvent> get thisWeekTopicsEvents => thisWeekTopic?.groupSessionProgramEvents ?? [];

  Duration get timePassedSinceSessionStart {
    // TODO uncomment in release code
    // final startTime = signedGroupSessionStartTime;
    //
    // if (startTime == null) return Duration.zero;
    //
    // return DateTime.now().difference(startTime);

    // TODO for testing
    // return DateTime.now()
    //     .difference(DateFormat('yyyy-MM-ddTHH:mm:ss').parse('2023-08-28T12:31:00.000Z', true));

    return Duration.zero;
  }

  Duration get timeLeftToSessionStart {
    // TODO uncomment in release code
    // final startTime = signedGroupSessionStartTime;
    //
    // if (startTime == null) return Duration.zero;
    //
    // TODO for testing
    // return DateFormat('yyyy-MM-ddTHH:mm:ss')
    //     .parse('2023-08-28T12:31:00.000Z', true)
    //     .difference(DateTime.now());

    return Duration.zero;
  }

  List<GroupSessionProgramEvent> get textEvents {
    final events = thisWeekTopicsEvents;

    if (events.isEmpty) return [];

    return events.where((event) => event.event == 'TEXT').toList();
  }

  List<GroupSessionProgramEvent> get videoEvents {
    final events = thisWeekTopicsEvents;

    if (events.isEmpty) return [];

    return events.where((event) => event.event == 'VIDEO').toList();
  }
}
