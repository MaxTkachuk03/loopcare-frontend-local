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

  Duration get durationLeftToSessionStart {
    // TODO hardcode for testing
    // final sessionDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse("2023-08-24T22:12:00.000Z");
    final sessionDate = DateTime.now().add(const Duration(seconds: 10));

    return sessionDate.difference(DateTime.now());
    // return signedGroupSessionStartTime?.difference(DateTime.now());
  }
}
