import 'package:freezed_annotation/freezed_annotation.dart';

part 'reflection_question_option.freezed.dart';

part 'reflection_question_option.g.dart';

@freezed
class ReflectionQuestionOption with _$ReflectionQuestionOption {
  const ReflectionQuestionOption._();

  const factory ReflectionQuestionOption({
    required int id,
    required String label,
    required String? value,
  }) = _ReflectionQuestionOption;

  factory ReflectionQuestionOption.fromJson(Map<String, dynamic> json) =>
      _$ReflectionQuestionOptionFromJson(json);
}
