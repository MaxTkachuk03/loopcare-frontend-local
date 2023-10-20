import 'package:freezed_annotation/freezed_annotation.dart';
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

  bool get isSessionAlreadyStarted => startDate.isBefore(DateTime.now());

  // TODO move to constants
  bool get isStartedLessThanFifteenMinutesAgo =>
      DateTime.now().difference(startDate.toLocal()).inMinutes < 15;

  bool get isSessionEnded => DateTime.now().toLocal().isAfter(endDate.toLocal());

  get availableSeatsAmount => maxMemberCount - memberCount;

  DateTime get localStartTime => startDate.toLocal();

  DateTime get localEndTime => endDate.toLocal();

  factory GroupSession.fromJson(Map<String, dynamic> json) => _$GroupSessionFromJson(json);
}
