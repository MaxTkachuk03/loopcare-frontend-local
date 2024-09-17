import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_topic.dart';

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
    required List<InteractiveLessonTopic> topics,
  }) = _InteractiveLesson;

  factory InteractiveLesson.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonFromJson(json);
}
