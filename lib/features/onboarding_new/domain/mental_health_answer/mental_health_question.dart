import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';

part 'mental_health_question.freezed.dart';
part 'mental_health_question.g.dart';

@freezed
abstract class MentalHealthQuestion implements _$MentalHealthQuestion {
  const MentalHealthQuestion._();

  const factory MentalHealthQuestion({
    required int id,
    required String title,
    required GenderType? excludeGender,
  }) = _MentalHealthQuestion;

  factory MentalHealthQuestion.fromJson(Map<String, dynamic> json) => _$MentalHealthQuestionFromJson(json);
}
