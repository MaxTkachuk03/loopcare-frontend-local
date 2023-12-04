import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/quizzes/domain/lesson_question.dart';

part 'lesson_questions_response.g.dart';

@immutable
@JsonSerializable()
class LessonQuestionsResponse {
  final List<LessonQuestion> data;

  const LessonQuestionsResponse({
    required this.data,
  });

  static LessonQuestionsResponse fromJson(Map<String, dynamic> json) =>
      _$LessonQuestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LessonQuestionsResponseToJson(this);
}
