import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/onboarding/domain/interpretation_type.dart';

part 'test_result.freezed.dart';

part 'test_result.g.dart';

@freezed
abstract class TestResult implements _$TestResult {
  const TestResult._();

  const factory TestResult({
    required int totalScore,
    required InterpretationType interpretation,
  }) = _TestResult;

  factory TestResult.fromJson(Map<String, dynamic> json) => _$TestResultFromJson(json);
}
