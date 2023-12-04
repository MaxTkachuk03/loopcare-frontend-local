import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_question_answer.freezed.dart';

part 'lesson_question_answer.g.dart';

@freezed
class LessonQuestionAnswer with _$LessonQuestionAnswer {
  const LessonQuestionAnswer._();

  const factory LessonQuestionAnswer({
    required int id,
    required int accountId,
    required int lessonQuestionId,
    required int? lessonQuestionOptionId,
    required String? text,
    required int? lessonQuestionFeedbackId,
  }) = _LessonQuestionAnswer;

  factory LessonQuestionAnswer.fromJson(Map<String, dynamic> json) => _$LessonQuestionAnswerFromJson(json);
}
