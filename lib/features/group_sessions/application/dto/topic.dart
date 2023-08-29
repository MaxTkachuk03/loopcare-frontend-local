import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session_program_event.dart';

part 'topic.freezed.dart';

part 'topic.g.dart';

@freezed
class Topic with _$Topic {
  const Topic._();

  const factory Topic({
    required List<GroupSession> groupSessions,
    required int id,
    required String topic,
    required int duration,
    required List<GroupSessionProgramEvent> groupSessionProgramEvents,
  }) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}
