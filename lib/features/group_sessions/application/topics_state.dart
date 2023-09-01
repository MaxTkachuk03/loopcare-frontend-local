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

  // TODO have same getter signedGroupSession
  GroupSession? get _signedGroupSessions {
    return topics[DateTime.now().weekNumber]
        ?.groupSessions
        .firstWhereOrNull((element) => element.signed == true);
  }

  bool get isSigned {
    return _signedGroupSessions != null ? true : false;
  }

  DateTime? get signedGroupSessionStartTime => signedGroupSession?.startDate.toLocal();

  DateTime? get signedGroupSessionsEndTime =>
      signedGroupSessionStartTime?.add(Duration(seconds: topics[DateTime.now().weekNumber]?.duration ?? 0));

  bool get signedGroupSessionsCancelledOrMissed {
    return _signedGroupSessions?.status == GroupSessionStatus.cancelled;
  }

  bool get signedGroupSessionsMissed {
    return _signedGroupSessions?.status == GroupSessionStatus.cancelled;
  }

  bool get signedGroupSessionsCancelled {
    return _signedGroupSessions?.status == GroupSessionStatus.cancelled;
  }

  // TODO can be simplified, calculations can be moved to the GroupSession model
  bool get signedGroupSessionsMightBeCancelled {
    if (isSigned) {
      if (DateTime.now()
              .isAfter(signedGroupSessionStartTime?.subtract(const Duration(hours: 1)) ?? DateTime.now()) &&
          DateTime.now().isBefore(signedGroupSessionStartTime ?? DateTime.now())) {
        return _signedGroupSessions!.memberCount < _signedGroupSessions!.minMemberCount;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool get isGroupsOnThisWeekAvailable {
    int sessionsAvailableOnThisWeek = topics[DateTime.now().weekNumber]
            ?.groupSessions
            .where((element) => element.startDate
                .add(Duration(seconds: topics[DateTime.now().weekNumber]?.duration ?? 0))
                .toLocal()
                .isAfter(DateTime.now()))
            .toList()
            .length ??
        0;
    return sessionsAvailableOnThisWeek > 0;
  }

  bool get isCanJoin => timeLeftToSessionStart < const Duration(minutes: 10);

  // TODO move to the GroupSession model
  bool get timeSlotsAvailable {
    var freeSlots = 0;
    topics[DateTime.now().weekNumber]?.groupSessions.forEach((element) {
      if (element.startDate.toLocal().isAfter(DateTime.now()) &&
          element.status != GroupSessionStatus.cancelled) {
        freeSlots += element.maxMemberCount - element.memberCount;
      }
    });
    return freeSlots > 0;
  }

  String get thisWeekTopicName => topics[DateTime.now().weekNumber]?.topic ?? '';

  String get nextWeekTopicName => topics[DateTime.now().nextWeekNumber]?.topic ?? '';

  GroupSession? get signedGroupSession => thisWeekTopic?.groupSessions.firstWhereOrNull((s) => s.signed);

  String? get signedGroupSessionToken => signedGroupSession?.signature;

  String? get signedGroupSessionPassword => signedGroupSession?.password;

  int? get signedGroupSessionId => signedGroupSession?.id;

  List<GroupSessionProgramEvent> get thisWeekTopicsEvents => thisWeekTopic?.groupSessionProgramEvents ?? [];

  // TODO move to the GroupSession model
  Duration get timePassedSinceSessionStart {
    final startTime = signedGroupSessionStartTime;

    if (startTime == null) return Duration.zero;

    return DateTime.now().difference(startTime);
  }

  // TODO move to the GroupSession model
  Duration get timeLeftToSessionStart {
    final startTime = signedGroupSessionStartTime;

    if (startTime == null) return Duration.zero;

    return startTime.difference(DateTime.now());
  }

  // TODO move to enum
  List<GroupSessionProgramEvent> get textEvents {
    final events = thisWeekTopicsEvents;

    if (events.isEmpty) return [];

    return events.where((event) => event.event == 'TEXT').toList();
  }

  // TODO move to enum
  List<GroupSessionProgramEvent> get videoEvents {
    final events = thisWeekTopicsEvents;

    if (events.isEmpty) return [];

    return events.where((event) => event.event == 'VIDEO').toList();
  }
}
