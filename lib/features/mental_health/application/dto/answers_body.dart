import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/mental_health/domain/mental_health_answer.dart';

part 'answers_body.freezed.dart';

part 'answers_body.g.dart';

@freezed
abstract class AnswersBody implements _$AnswersBody {
  const factory AnswersBody({
    required List<MentalHealthAnswer> answers,
  }) = _AnswersBody;

  const AnswersBody._();

  factory AnswersBody.fromJson(Map<String, dynamic> json) =>
      _$AnswersBodyFromJson(json);
}
