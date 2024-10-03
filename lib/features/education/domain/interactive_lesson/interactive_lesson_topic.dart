import 'package:freezed_annotation/freezed_annotation.dart';

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
}
