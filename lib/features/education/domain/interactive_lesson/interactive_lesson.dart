import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topic.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topics_page.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'interactive_lesson.freezed.dart';
part 'interactive_lesson.g.dart';

@freezed
class InteractiveLesson with _$InteractiveLesson {
  const InteractiveLesson._();

  const factory InteractiveLesson({
    required int id,
    String? type,
    required String title,
    required String jumpBoardTitle,
    required String jumpBoardDescription,
    required String conclusion,
    String? unlockTitle,
    String? unlockDescription,
    required Map<int, InteractiveLessonTopic> topics,
    required Map<int, InteractiveLessonTopicsPage> pages,
    required Map<int, InteractiveLessonChunk> chunks,
    required Map<int, InteractiveLessonChunkComponent> components,
    required int? riverModuleItem,
    required String? iconType,
  }) = _InteractiveLesson;

  factory InteractiveLesson.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonFromJson(json);

  factory InteractiveLesson.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Starting InteractiveLesson.fromJson');
      log.d('Raw JSON: $json');

      // Add logging for individual fields
      final id = json['id'] as int;
      log.d('Parsed id: $id');

      final type = json['streamType'] as String;
      log.d('Parsed type: ${json['streamType']}');

      final title = json['title'] as String;

      log.d('Parsed title: $title');
      log.d('Raw topics: ${json['topics']}');
      log.d('Raw pages: ${json['pages']}');
      log.d('Raw chunks: ${json['chunks']}');
      log.d('Raw components: ${json['components']}');
      return InteractiveLesson(
        id: id,
        type: type,
        title: title,
        jumpBoardTitle: json['jumpBoardTitle'] as String,
        jumpBoardDescription: json['jumpBoardDescription'] as String,
        conclusion: json['conclusion'] as String,
        unlockTitle: json['unlockTitle'] as String?,
        unlockDescription: json['unlockDescription'] as String?,
        riverModuleItem: json['riverModuleItem']?['id'] as int?,
        iconType: json['riverModuleItem']?['iconType'] as String?,
        topics: Map.fromEntries(
          (json['topics'] as List<dynamic>)
              .map((value) => InteractiveLessonTopic.debugFromJson(value as Map<String, dynamic>))
              .map((topic) => MapEntry(topic.id, topic)), // Use topic.id as the key
        ),
        pages: Map.fromEntries(
          (json['pages'] as List<dynamic>)
              .map((value) =>
                  InteractiveLessonTopicsPage.debugFromJson(value as Map<String, dynamic>))
              .map((page) => MapEntry(page.id, page)),
        ),
        chunks: Map.fromEntries(
          (json['chunks'] as List<dynamic>)
              .map((value) => InteractiveLessonChunk.debugFromJson(value as Map<String, dynamic>))
              .map((chunk) => MapEntry(chunk.id, chunk)),
        ),
        components: Map.fromEntries(
          (json['components'] as List<dynamic>)
              .map((value) =>
                  InteractiveLessonChunkComponent.debugFromJson(value as Map<String, dynamic>))
              .map((component) => MapEntry(component.id, component)),
        ),
      );
    } catch (e, stackTrace) {
      log.w('Error in InteractiveLesson.fromJson: $e');
      log.w('Stack Trace: $stackTrace');
      log.w('Problematic JSON: $json');
      rethrow; // Ensure the error propagates up the call stack
    }
  }
}
