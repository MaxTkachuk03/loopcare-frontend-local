import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'interactive_lesson_topic.freezed.dart';
part 'interactive_lesson_topic.g.dart';

@freezed
class InteractiveLessonTopic with _$InteractiveLessonTopic {
  const InteractiveLessonTopic._();

  const factory InteractiveLessonTopic({
    required int id,
    required String title,
    required String description,
    required List<int> pagesIds,
  }) = _InteractiveLessonTopic;

  factory InteractiveLessonTopic.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonTopicFromJson(json);

  factory InteractiveLessonTopic.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing InteractiveLessonTopic: $json');
      return InteractiveLessonTopic(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        pagesIds: (json['pageIds'] as List).map((e) => e as int).toList(),
      );
    } catch (e, stackTrace) {
      log.d('Error in InteractiveLessonTopic.fromJson: $e');
      log.d('Stack Trace: $stackTrace');
      log.d('Problematic JSON: $json');
      rethrow; // Rethrow to propagate the error up the stack
    }
  }
}
