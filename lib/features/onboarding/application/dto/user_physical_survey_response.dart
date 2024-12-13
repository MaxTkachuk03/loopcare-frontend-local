import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_physical_survey_response.g.dart';

@immutable
@JsonSerializable()
class UserPhysicalSurveyResponse {
  final int id;
  final int height;
  final DateTime birthDate;
  final int weight;
  final double bmi;
  final int account;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserPhysicalSurveyResponse({
    required this.id,
    required this.height,
    required this.birthDate,
    required this.weight,
    required this.bmi,
    required this.account,
    required this.createdAt,
    required this.updatedAt,
  });

  static UserPhysicalSurveyResponse fromJson(Map<String, dynamic> json) =>
      _$UserPhysicalSurveyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserPhysicalSurveyResponseToJson(this);
}
