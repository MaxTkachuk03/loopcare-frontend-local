import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/group_sessions/domain/group_session_status.dart';

part 'group_session.freezed.dart';

part 'group_session.g.dart';

@freezed
abstract class GroupSession implements _$GroupSession {
  const GroupSession._();

  const factory GroupSession({
    required String? signature,
    required int memberCount,
    required int minMemberCount,
    required int maxMemberCount,
    required GroupSessionStatus status,
    required bool signed,
    required int id,
    required String topic,
    required DateTime startDate,
    required String password,
  }) = _GroupSession;

  factory GroupSession.fromJson(Map<String, dynamic> json) => _$GroupSessionFromJson(json);
}
