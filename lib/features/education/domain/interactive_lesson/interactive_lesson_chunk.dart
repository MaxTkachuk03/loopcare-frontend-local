import 'package:freezed_annotation/freezed_annotation.dart';

part 'interactive_lesson_chunk.freezed.dart';
part 'interactive_lesson_chunk.g.dart';

@freezed
class InteractiveLessonChunk with _$InteractiveLessonChunk {
  const InteractiveLessonChunk._();

  const factory InteractiveLessonChunk({
    required int id,
    required String title,
    required int pageId,
    required List<int> componentsIds,
  }) = _InteractiveLessonChunk;

  factory InteractiveLessonChunk.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonChunkFromJson(json);
}
