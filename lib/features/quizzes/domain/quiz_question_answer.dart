import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_question_answer.freezed.dart';

part 'quiz_question_answer.g.dart';

@freezed
class QuizQuestionAnswer with _$QuizQuestionAnswer {
  const QuizQuestionAnswer._();

  const factory QuizQuestionAnswer({
    required int optionId,
  }) = _QuizQuestionAnswer;

  factory QuizQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionAnswerFromJson(json);
}
