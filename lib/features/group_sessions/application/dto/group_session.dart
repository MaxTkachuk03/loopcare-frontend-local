import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_session.freezed.dart';

part 'group_session.g.dart';

@freezed
class GroupSession with _$GroupSession {
  const GroupSession._();

  const factory GroupSession({
    required String signature,
    required int memberCount,
    required int minMemberCount,
    required int maxMemberCount,
    required String status,
    required bool signed,
    required int id,
    required String topic,
    required DateTime startDate,
    required String password,
  }) = _GroupSession;

  bool get isSessionAlreadyStarted => startDate.isBefore(DateTime.now());

  bool get isStartedLessThanFifteenMinutesAgo =>
      DateTime.now().difference(startDate.toLocal()).inMinutes < 15;

  factory GroupSession.fromJson(Map<String, dynamic> json) => _$GroupSessionFromJson(json);
}
