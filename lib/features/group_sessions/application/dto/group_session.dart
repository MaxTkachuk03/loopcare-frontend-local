import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/group_sessions/domain/group_session_constants.dart';
import 'package:loopcare_frontend/features/group_sessions/domain/group_session_status.dart';
import 'package:loopcare_frontend/features/group_sessions/domain/member_session_status.dart';

part 'group_session.freezed.dart';

part 'group_session.g.dart';

@freezed
class GroupSession with _$GroupSession {
  const GroupSession._();

  const factory GroupSession({
    required int memberCount,
    required int minMemberCount,
    required int maxMemberCount,
    required GroupSessionStatus status,
    required bool signed,
    required int id,
    required String topic,
    required DateTime startDate,
    required DateTime endDate,
    required String password,
    required MemberSessionStatus? memberStatus,
    required String groupSessionKey,
  }) = _GroupSession;

  bool get _isNotEnded => DateTime.now().isBefore(localEndTime);

  bool get _hasFreeSlots => maxMemberCount - memberCount > 0;

  bool get hasTimeSlots {
    if (status == GroupSessionStatus.cancelled) return false;

    return _isNotEnded && _hasFreeSlots;
  }

  bool get isCanceled => status == GroupSessionStatus.cancelled;

  bool get lessThanHourBeforeStart => localStartTime.difference(DateTime.now()).inMinutes < 60;

  // TODO check with Diana session is completed state we dont have completed state right now
  bool get isCompleted => isSessionEnded;

  bool get isInProgress => isSessionAlreadyStarted && isSessionNotEnded;

  bool get isMinUsersReached => memberCount >= minMemberCount;

  bool get isSessionNotEnded =>
      DateTime.now().isBefore(localEndTime) || DateTime.now().isAtSameMomentAs(localEndTime);

  bool get isSessionAlreadyStarted =>
      DateTime.now().isAfter(localStartTime) || DateTime.now().isAtSameMomentAs(localStartTime);

  bool get isStartedLessThanFifteenMinutesAgo =>
      DateTime.now().difference(startDate.toLocal()).inMinutes <
      GroupSessionConstants.timeUserCanRejoinToSession;

  bool get isSessionEnded => DateTime.now().isAfter(endDate.toLocal());

  int get availableSeatsAmount => maxMemberCount - memberCount;

  DateTime get localStartTime => startDate.toLocal();

  DateTime get localEndTime => endDate.toLocal();

  factory GroupSession.fromJson(Map<String, dynamic> json) => _$GroupSessionFromJson(json);
}
