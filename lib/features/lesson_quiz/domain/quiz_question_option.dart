import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_question_option.freezed.dart';

part 'quiz_question_option.g.dart';

@freezed
class QuizQuestionOption with _$QuizQuestionOption {
  const QuizQuestionOption._();

  const factory QuizQuestionOption({
    required String? value,
    required bool? isCorrect,
    required int id,
    required String label,
  }) = _QuizQuestionOption;

  factory QuizQuestionOption.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionOptionFromJson(json);
}
