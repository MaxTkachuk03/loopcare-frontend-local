import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/food_preferences/food_preferences.dart';
import 'package:loopcare_frontend/core/domain/physical_fitness/physical_fitness.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_type.dart';

part 'account_response.g.dart';

@immutable
@JsonSerializable()
class AccountResponse {
  final int id;
  final String name;
  final String email;
  final String? country;
  final bool isPreferencesComplete;
  final DateTime emailApproveDate;
  final String measurementSystem;
  final bool isConsentApproved;
  final bool isLegalApproved;
  final String gender;
  final String bioGender;
  final PhysicalFitness physicalFitness;
  final DiabetesType diabetes;
  final FoodPreferences foodPreferences;

  const AccountResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.isPreferencesComplete,
    required this.emailApproveDate,
    required this.measurementSystem,
    required this.isConsentApproved,
    required this.isLegalApproved,
    required this.gender,
    required this.bioGender,
    required this.physicalFitness,
    required this.diabetes,
    required this.foodPreferences,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) => _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}
