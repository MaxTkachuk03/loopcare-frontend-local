import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_select_answer.freezed.dart';
part 'content_select_answer.g.dart';

@freezed
class ContentSelectAnswer with _$ContentSelectAnswer {
  const factory ContentSelectAnswer({
    required int id,
    required String label,
    @Default(null) bool? isCorrect,
  }) = _ContentSelectAnswer;

  factory ContentSelectAnswer.fromJson(Map<String, dynamic> json) =>
      _$ContentSelectAnswerFromJson(json);
}
