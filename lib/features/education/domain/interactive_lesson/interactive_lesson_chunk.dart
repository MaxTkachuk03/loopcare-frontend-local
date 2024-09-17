import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';

part 'interactive_lesson_chunk.freezed.dart';
part 'interactive_lesson_chunk.g.dart';

@freezed
class InteractiveLessonChunk with _$InteractiveLessonChunk {
  const InteractiveLessonChunk._();

  const factory InteractiveLessonChunk({
    required int id,
    required String title,
    required List<InteractiveLessonChunkComponent> components,
  }) = _InteractiveLessonChunk;

  factory InteractiveLessonChunk.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonChunkFromJson(json);
}
