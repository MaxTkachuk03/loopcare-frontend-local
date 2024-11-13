import 'package:freezed_annotation/freezed_annotation.dart';

part 'reflection_question_answer.freezed.dart';

part 'reflection_question_answer.g.dart';

@freezed
class ReflectionQuestionAnswer with _$ReflectionQuestionAnswer {
  const ReflectionQuestionAnswer._();

  const factory ReflectionQuestionAnswer({
    required int id,
    required String? text,
    required int? optionId,
  }) = _ReflectionQuestionAnswer;

  factory ReflectionQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$ReflectionQuestionAnswerFromJson(json);
}
