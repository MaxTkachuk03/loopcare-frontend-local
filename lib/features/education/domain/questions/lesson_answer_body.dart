import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_answer_body.freezed.dart';

part 'lesson_answer_body.g.dart';

@freezed
class LessonAnswerTextBody with _$LessonAnswerTextBody {
  const LessonAnswerTextBody._();

  const factory LessonAnswerTextBody({
    String? text,
  }) = _LessonAnswerTextBody;

  factory LessonAnswerTextBody.fromJson(Map<String, dynamic> json) => _$LessonAnswerTextBodyFromJson(json);
}

@freezed
class LessonAnswerOptionBody with _$LessonAnswerOptionBody {
  const LessonAnswerOptionBody._();

  const factory LessonAnswerOptionBody({
    List<int>? lessonQuestionOptionIds,
    String? text,
  }) = _LessonAnswerOptionBody;

  factory LessonAnswerOptionBody.fromJson(Map<String, dynamic> json) =>
      _$LessonAnswerOptionBodyFromJson(json);
}
