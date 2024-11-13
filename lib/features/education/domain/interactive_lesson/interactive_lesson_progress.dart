import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/progress/answers.dart';

part 'interactive_lesson_progress.freezed.dart';
part 'interactive_lesson_progress.g.dart';


@freezed
class InteractiveLessonProgress with _$InteractiveLessonProgress {
  const InteractiveLessonProgress._();

  const factory InteractiveLessonProgress({
    required int lessonId,
    required int topicId,
    required int pageId,
    required int chunkId,
    required int componentId,
    required Answers answers,
  }) = _InteractiveLessonProgress;

  factory InteractiveLessonProgress.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonProgressFromJson(json);
}