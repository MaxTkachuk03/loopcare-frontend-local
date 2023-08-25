import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_session_program_event.freezed.dart';

part 'group_session_program_event.g.dart';

@freezed
abstract class GroupSessionProgramEvent implements _$GroupSessionProgramEvent {
  const GroupSessionProgramEvent._();

  const factory GroupSessionProgramEvent({
    required int id,
    required String event,
    required int timestamp,
    required String? text,
    required String? videoPath,
  }) = _GroupSessionProgramEvent;

  factory GroupSessionProgramEvent.fromJson(Map<String, dynamic> json) =>
      _$GroupSessionProgramEventFromJson(json);
}
