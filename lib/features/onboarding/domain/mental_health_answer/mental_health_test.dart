import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_option.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_question.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test_type.dart';

part 'mental_health_test.freezed.dart';
part 'mental_health_test.g.dart';

@freezed
abstract class MentalHealthTest implements _$MentalHealthTest {
  const MentalHealthTest._();

  const factory MentalHealthTest({
    required int id,
    required String title,
    required MentalHealthTestType type,
    required List<MentalHealthQuestion> questions,
    required List<MentalHealthOption> options,
  }) = _MentalHealthTest;

  factory MentalHealthTest.fromJson(Map<String, dynamic> json) => _$MentalHealthTestFromJson(json);
}
