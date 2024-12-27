import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

part 'save_interactive_lesson_progress_body.g.dart';

@immutable
@JsonSerializable()
class SaveInteractiveLessonProgressBody {
  final int topicId;
  final int pageId;
  final int lessonId;
  final int componentId;
  final String answerType;
  final String answeredAt;
  final InteractiveLessonComponentProgress progress;

  const SaveInteractiveLessonProgressBody({
    required this.topicId,
    required this.pageId,
    required this.lessonId,
    required this.componentId,
    required this.progress,
    required this.answerType,
    required this.answeredAt,
  });

  factory SaveInteractiveLessonProgressBody.fromJson(Map<String, dynamic> json) =>
      _$SaveInteractiveLessonProgressBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveInteractiveLessonProgressBodyToJson(this);
}
