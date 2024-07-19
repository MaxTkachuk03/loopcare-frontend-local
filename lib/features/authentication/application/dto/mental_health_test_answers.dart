import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_answer.dart';

part 'mental_health_test_answers.freezed.dart';
part 'mental_health_test_answers.g.dart';

@freezed
abstract class MentalHealthTestAnswer implements _$MentalHealthTestAnswer {
  const MentalHealthTestAnswer._();

  const factory MentalHealthTestAnswer({
    required List<MentalHealthAnswer> answers,
  }) = _MentalHealthTestAnswer;

  factory MentalHealthTestAnswer.fromJson(Map<String, dynamic> json) =>
      _$MentalHealthTestAnswerFromJson(json);
}
