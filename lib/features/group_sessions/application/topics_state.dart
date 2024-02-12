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

  List<GroupSessionProgramEvent>? get thisWeekTopicProgram => _thisWeekTopic?.groupSessionProgramEvents;

  String get weekTopicName => DateTime.now().isLastDayOfWeek ? _nextWeekTopicName : _thisWeekTopicName;

  String get _thisWeekTopicName => topics[DateTime.now().weekNumber]?.topic ?? '';

  String get _nextWeekTopicName => topics[DateTime.now().nextWeekNumber]?.topic ?? '';

  GroupSession? get signedGroupSession => weekTopic?.groupSessions.firstWhereOrNull((s) => s.signed);

  bool get isHappeningNow {
    var isHappeningNow = false;
    if (isSigned) {
      var sessionStartDate = signedGroupSessionStartTime;
      var sessionEndDate = signedGroupSessionsEndTime;
      var nowMoment = DateTime.now();
      if (sessionStartDate != null && sessionEndDate != null) {
        if (nowMoment.isAfter(sessionStartDate) && nowMoment.isBefore(sessionEndDate)) {
          isHappeningNow = true;
        }
      }
    }
    return isHappeningNow;
  }

  bool get isSignedInPast {
    if (signedGroupSession != null) {
      return DateTime.now().isAfter(signedGroupSessionsEndTime ?? DateTime.now());
    } else {
      return false;
    }
  }

  bool get isSigned {
    return signedGroupSession != null ? true : false;
  }

  DateTime? get signedGroupSessionStartTime => signedGroupSession?.localStartTime;

  DateTime? get signedGroupSessionsEndTime => signedGroupSession?.localEndTime;

  bool get signedGroupSessionsCancelledOrMissed {
    return signedGroupSession?.status == GroupSessionStatus.cancelled;
  }

  bool get signedGroupSessionsMissed {
    return signedGroupSession?.status == GroupSessionStatus.cancelled;
  }

  bool get signedGroupSessionFinished {
    return signedGroupSession?.status == GroupSessionStatus.finished;
  }

  bool get signedGroupSessionsCancelled {
    return signedGroupSession?.status == GroupSessionStatus.cancelled;
  }

  // TODO can be simplified, calculations can be moved to the GroupSession model
  bool get signedGroupSessionsMightBeCancelled {
    if (isSigned) {
      if (DateTime.now()
              .isAfter(signedGroupSessionStartTime?.subtract(const Duration(hours: 1)) ?? DateTime.now()) &&
          DateTime.now().isBefore(signedGroupSessionStartTime ?? DateTime.now())) {
        return signedGroupSession!.memberCount < signedGroupSession!.minMemberCount;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool get isGroupsOnWeekAvailable {
    if (isSignedInPast) return false;

    int sessionsAvailableOnThisWeek = weekTopic?.groupSessions
            .where(
              (element) =>
                  element.startDate.add(Duration(seconds: weekTopic?.duration ?? 0)).toLocal().isAfter(
                        DateTime.now(),
                      ) &&
                  (element.status == GroupSessionStatus.planned ||
                      element.status == GroupSessionStatus.active),
            )
            .toList()
            .length ??
        0;
    return sessionsAvailableOnThisWeek > 0;
  }

  Future<bool> get isCanJoin async {
    final timeToSessionStart = await timeLeftToSessionStart;
    final ntpTime = await TimeService.now;
    final isMoreThanTenMinutesLeft =
        timeToSessionStart > const Duration(minutes: 0) && timeToSessionStart < const Duration(minutes: 10);

    final isSessionIsInProgress = ntpTime.isAfter(signedGroupSessionStartTime ?? ntpTime) &&
        ntpTime.isBefore(signedGroupSessionsEndTime ?? ntpTime);

    return isMoreThanTenMinutesLeft || isSessionIsInProgress;
  }

  // TODO move to the GroupSession model
  bool get timeSlotsAvailable {
    var freeSlots = 0;
    weekTopic?.groupSessions.forEach((element) {
      if (element.status != GroupSessionStatus.cancelled) {
        var endTime = element.startDate.add(Duration(seconds: weekTopic?.duration ?? 0)).toLocal();
        var isAfterNow = endTime.isAfter(DateTime.now());
        if (isAfterNow) {
          freeSlots += element.maxMemberCount - element.memberCount;
        }
      }
    });
    return freeSlots > 0;
  }

  String? get signedGroupSessionPassword => signedGroupSession?.password;

  String? get signedGroupSessionKey => signedGroupSession?.groupSessionKey;

  int? get signedGroupSessionId => signedGroupSession?.id;

  List<GroupSessionProgramEvent> get thisWeekTopicsEvents => _thisWeekTopic?.groupSessionProgramEvents ?? [];

  String get thisWeekTopicsImage => _thisWeekTopic?.image ?? '';

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
        .sorted((a, b) => a.timestamp.compareObjectTo(b.timestamp))
        .toList();
  }

  List<GroupSessionProgramEvent> get videoEvents {
    final events = thisWeekTopicsEvents;

    if (events.isEmpty) return [];

    return events.where((event) => event.event == GroupSessionEventType.VIDEO.name).toList();
  }
}
