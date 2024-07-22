import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_question_feedback.freezed.dart';

part 'lesson_question_feedback.g.dart';

@freezed
class LessonQuestionFeedback with _$LessonQuestionFeedback {
  const LessonQuestionFeedback._();

  const factory LessonQuestionFeedback({
    required int id,
    required int minValue,
    required int maxValue,
    required String text,
    required int lessonQuestionId,
  }) = _LessonQuestionFeedback;

  factory LessonQuestionFeedback.fromJson(Map<String, dynamic> json) =>
      _$LessonQuestionFeedbackFromJson(json);
}
