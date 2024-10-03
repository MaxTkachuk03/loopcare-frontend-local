import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topic.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topics_page.dart';

part 'interactive_lesson.freezed.dart';
part 'interactive_lesson.g.dart';

@freezed
class InteractiveLesson with _$InteractiveLesson {
  const InteractiveLesson._();

  const factory InteractiveLesson({
    required int id,
    required String title,
    required String jumpBoardTitle,
    required String jumpBoardDescription,
    required String conclusion,
    required String unlockTitle,
    required String unlockDescription,
    required Map<int, InteractiveLessonTopic> topics,
    required Map<int, InteractiveLessonTopicsPage> pages,
    required Map<int, InteractiveLessonChunk> chunks,
    required Map<int, InteractiveLessonChunkComponent> components,
  }) = _InteractiveLesson;

  factory InteractiveLesson.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonFromJson(json);
}
