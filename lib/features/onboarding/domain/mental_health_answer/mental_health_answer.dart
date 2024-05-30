import 'package:freezed_annotation/freezed_annotation.dart';

part 'mental_health_answer.freezed.dart';
part 'mental_health_answer.g.dart';

@freezed
abstract class MentalHealthAnswer implements _$MentalHealthAnswer {
  const MentalHealthAnswer._();

  const factory MentalHealthAnswer({
    required int questionId,
    required int optionId,
  }) = _MentalHealthAnswer;

  factory MentalHealthAnswer.fromJson(Map<String, dynamic> json) =>
      _$MentalHealthAnswerFromJson(json);
}
