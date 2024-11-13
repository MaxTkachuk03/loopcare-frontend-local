import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/onboarding/domain/mental_health_answer/mental_health_test.dart';

part 'mental_health_tests_response.g.dart';

@immutable
@JsonSerializable()
class MentalHealthTestsResponse {
  final List<MentalHealthTest> data;

  const MentalHealthTestsResponse(this.data);

  static MentalHealthTestsResponse fromJson(Map<String, dynamic> json) =>
      _$MentalHealthTestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MentalHealthTestsResponseToJson(this);
}
