import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_lesson_quiz_question_answer_body.g.dart';

@immutable
@JsonSerializable()
class SaveLessonQuizQuestionAnswerBody {
  final List<int> lessonQuizQuestionOptionIds;
  final int lessonQuizQuestionId;

  const SaveLessonQuizQuestionAnswerBody({
    required this.lessonQuizQuestionOptionIds,
    required this.lessonQuizQuestionId,
  });

  factory SaveLessonQuizQuestionAnswerBody.fromJson(Map<String, dynamic> json) =>
      _$SaveLessonQuizQuestionAnswerBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveLessonQuizQuestionAnswerBodyToJson(this);
}
