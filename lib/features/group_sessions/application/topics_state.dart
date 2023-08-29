part of 'topics_bloc.dart';

@freezed
class TopicsState with _$TopicsState {
  const TopicsState._();

  const factory TopicsState.initial(TopicsData data) = TopicsStateInitial;

  const factory TopicsState.updated(TopicsData data) = TopicsStateUpdated;

  const factory TopicsState.loading(TopicsData data) = TopicsStateLoading;

  const factory TopicsState.error(TopicsData data) = TopicsStateError;
}

@freezed
class TopicsData with _$TopicsData {
  const TopicsData._();

  const factory TopicsData({
    @Default({}) Map<int, Topic> topics,
    @Default('') String signedSessionSignature,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _TopicsData;

  Topic? get thisWeekTopic => topics[DateTime.now().weekNumber];

  List<GroupSessionProgramEvent>? get thisWeekTopicProgram => thisWeekTopic?.groupSessionProgramEvents;

  String get topicName => topics[DateTime.now().weekNumber]?.topic ?? '';

  bool get isSigned {
    return signedGroupSessions != null ? true : false;
  }

  GroupSession? get signedGroupSessions {
    return topics[DateTime.now().weekNumber]
        ?.groupSessions
        .firstWhereOrNull((element) => element.signed == true);
  }

  DateTime get signedGroupSessionsEndDate {
    DateTime session = topics[DateTime.now().weekNumber]
            ?.groupSessions
            .firstWhereOrNull((element) => element.signed == true)
            ?.startDate ??
        DateTime.now();

    return session.add(Duration(seconds: topics[DateTime.now().weekNumber]?.duration ?? 0));
  }

  bool get signedGroupSessionsCancelledOrMissed {
    // return signedGroupSessions?.status == GroupSessionStatus.cancelled.name;
    return true;
  }

  bool get signedGroupSessionsMissed {
    // return signedGroupSessions?.status == GroupSessionStatus.cancelled.name;
    return true;
  }

  bool get signedGroupSessionsCancelled {
    return signedGroupSessions?.status == GroupSessionStatus.cancelled.name;
  }

  bool get signedGroupSessionsMightBeCancelled {
    if (isSigned) {
      return signedGroupSessions!.memberCount < signedGroupSessions!.minMemberCount;
    } else {
      return false;
    }
  }

  bool get timeSlotsAvailable {
    var freeSlots = 0;
    topics[DateTime.now().weekNumber]?.groupSessions.forEach((element) {
      if (element.startDate.isAfter(DateTime.now())) {
        freeSlots += element.maxMemberCount - element.memberCount;
      }
    });
    return freeSlots > 0;
  }

  String get thisWeekTopicName => topics[DateTime.now().weekNumber]?.topic ?? '';

  String get nextWeekTopicName => topics[DateTime.now().nextWeekNumber]?.topic ?? '';

  GroupSession? get signedGroupSession => thisWeekTopic?.groupSessions.firstWhereOrNull((s) => s.signed);

  DateTime? get signedGroupSessionStartTime => signedGroupSession?.startDate;

  String? get signedGroupSessionPassword => signedGroupSession?.password;

  int? get signedGroupSessionId => signedGroupSession?.id;

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
