import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question_answer.dart';

part 'lesson_question_option.freezed.dart';

part 'lesson_question_option.g.dart';

@freezed
class LessonQuestionOption with _$LessonQuestionOption {
  const LessonQuestionOption._();

  const factory LessonQuestionOption({
    required String? value,
    required bool? isCorrect,
    required List<LessonQuestionAnswer>? lessonQuestionAnswers,
    required int id,
    required String label,
    required int lessonQuestionId,
  }) = _LessonQuestionOption;

  factory LessonQuestionOption.fromJson(Map<String, dynamic> json) => _$LessonQuestionOptionFromJson(json);
}
