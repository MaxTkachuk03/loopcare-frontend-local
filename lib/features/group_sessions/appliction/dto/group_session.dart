import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_session.freezed.dart';

part 'group_session.g.dart';

@freezed
abstract class GroupSession implements _$GroupSession {
  const GroupSession._();

  const factory GroupSession({
    required String signature,
    required dynamic groupSessionProgram,
    required int id,
    required String topic,
    required DateTime startDate,
    required String password,
  }) = _GroupSession;

  factory GroupSession.fromJson(Map<String, dynamic> json) => _$GroupSessionFromJson(json);
}
