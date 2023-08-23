import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/mental_health/domain/interpretation_type.dart';

part 'test_results_response.g.dart';

@immutable
@JsonSerializable()
class TestResultsResponse {
  final int totalScore;
  final InterpretationType interpretation;

  const TestResultsResponse(this.totalScore, this.interpretation);

  static TestResultsResponse fromJson(Map<String, dynamic> json) =>
      _$TestResultsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TestResultsResponseToJson(this);
}
