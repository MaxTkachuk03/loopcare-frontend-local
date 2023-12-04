import 'package:freezed_annotation/freezed_annotation.dart';

part 'mental_health_tests.freezed.dart';

part 'mental_health_tests.g.dart';

@freezed
class MentalHealthTests with _$MentalHealthTests {
  const MentalHealthTests._();

  const factory MentalHealthTests({
    required String who5,
    required String phq8,
    required String phq15,
    required String gad7,
  }) = _MentalHealthTests;

  factory MentalHealthTests.fromJson(Map<String, dynamic> json) => _$MentalHealthTestsFromJson(json);
}
