import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_session_program_event.freezed.dart';

part 'group_session_program_event.g.dart';

@freezed
class GroupSessionProgramEvent with _$GroupSessionProgramEvent {
  const GroupSessionProgramEvent._();

  const factory GroupSessionProgramEvent({
    required int id,
    required String event,
    required int timestamp,
    required int? duration,
    required String? text,
    required String? videoPath,
  }) = _GroupSessionProgramEvent;

  int get eventEndTime => timestamp + (duration ?? 0);

  int get eventStartTime => timestamp;

  factory GroupSessionProgramEvent.fromJson(Map<String, dynamic> json) =>
      _$GroupSessionProgramEventFromJson(json);
}
