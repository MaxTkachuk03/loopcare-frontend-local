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

  Topic? get _thisWeekTopic => topics[DateTime.now().weekNumber];

  Topic? get _nextWeekTopic => topics[DateTime.now().nextWeekNumber];

  Topic? get weekTopic => DateTime.now().isLastDayOfWeek ? _nextWeekTopic : _thisWeekTopic;

  bool get topicHasFreeTimeSlots => weekTopic?.hasTimeSlots ?? false;

  bool get topicHasSessions => weekTopic?.hasSessions ?? false;

  bool get isNotSignedHasFreeTimeSlots => !isSigned && topicHasFreeTimeSlots;

  bool get isNotSignedHasNoFreeTimeSlots => !isSigned && !topicHasFreeTimeSlots;

  bool get isNotSignedNoSessions => !isSigned && !topicHasSessions;

  bool get signedMinUsersNotReached =>
      signedGroupSession != null &&
      !signedGroupSession!.isCanceled &&
      signedGroupSession!.lessThanHourBeforeStart &&
      !signedGroupSession!.isMinUsersReached;

  bool get signedSessionCanceledHasOtherSlots =>
      signedGroupSession != null && signedGroupSession!.isCanceled && topicHasFreeTimeSlots;

  bool get signedSessionCanceledNoOtherSlots =>
      signedGroupSession != null && signedGroupSession!.isCanceled && !topicHasFreeTimeSlots;

  bool get signedSessionCompleted => signedGroupSession != null && signedGroupSession!.isCompleted;

  bool get signedSessionInProgress =>
      signedGroupSession != null && signedGroupSession!.isInProgress;

  bool get signedSessionNotStarted =>
      signedGroupSession != null && !signedGroupSession!.isSessionAlreadyStarted;

  List<GroupSessionProgramEvent>? get thisWeekTopicProgram =>
      _thisWeekTopic?.groupSessionProgramEvents;

  String get weekTopicName =>
      DateTime.now().isLastDayOfWeek ? _nextWeekTopicName : _thisWeekTopicName;

  String get _thisWeekTopicName => topics[DateTime.now().weekNumber]?.topic ?? '';

  String get _nextWeekTopicName => topics[DateTime.now().nextWeekNumber]?.topic ?? '';

  GroupSession? get signedGroupSession =>
      weekTopic?.groupSessions.firstWhereOrNull((s) => s.signed);

  bool get isSigned => signedGroupSession != null;

  DateTime? get signedGroupSessionStartTime => signedGroupSession?.localStartTime;

  DateTime? get signedGroupSessionsEndTime => signedGroupSession?.localEndTime;

  bool get signedGroupSessionsCancelledOrMissed =>
      signedGroupSession?.status == GroupSessionStatus.cancelled;

  bool get signedGroupSessionsMissed => signedGroupSession?.status == GroupSessionStatus.cancelled;

  bool get signedGroupSessionFinished => signedGroupSession?.status == GroupSessionStatus.finished;

  bool get signedGroupSessionsCancelled =>
      signedGroupSession?.status == GroupSessionStatus.cancelled;

  String? get signedGroupSessionPassword => signedGroupSession?.password;

  String? get signedGroupSessionKey => signedGroupSession?.groupSessionKey;

  int? get signedGroupSessionId => signedGroupSession?.id;

  List<GroupSessionProgramEvent> get thisWeekTopicsEvents =>
      _thisWeekTopic?.groupSessionProgramEvents ?? [];

  String get thisWeekTopicsImage => _thisWeekTopic?.image ?? '';

  List<GroupSession> get weeklyTopicSortedSessions {
    List<GroupSession> groupSessions = [...?weekTopic?.groupSessions];

    groupSessions.sort((s1, s2) => s1.startDate.compareTo(s2.startDate));

    return groupSessions;
  }

  // TODO move to the GroupSession model
  Future<Duration> get timePassedSinceSessionStart async {
    final startTime = signedGroupSessionStartTime;

    if (startTime == null) return Duration.zero;

    final ntpTime = await TimeService.now;

    return ntpTime.difference(startTime);
  }

  // TODO move to the GroupSession model
  Future<Duration> get timeLeftToSessionStart async {
    final startTime = signedGroupSessionStartTime;

    if (startTime == null) return Duration.zero;

    return startTime.difference(await TimeService.now);
  }

  List<GroupSessionProgramEvent> get textEvents {
    final events = thisWeekTopicsEvents;

    if (events.isEmpty) return [];

    return events
        .where((event) => event.event == GroupSessionEventType.TEXT.name)
        .sorted((a, b) => a.timestamp.compareTo(b.timestamp))
        .toList();
  }

  List<GroupSessionProgramEvent> get videoEvents {
    final events = thisWeekTopicsEvents;

    if (events.isEmpty) return [];

    return events.where((event) => event.event == GroupSessionEventType.VIDEO.name).toList();
  }
}
