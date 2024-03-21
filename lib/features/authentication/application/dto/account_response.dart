import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/food_preferences/food_preferences.dart';
import 'package:loopcare_frontend/core/domain/grouping_preferences.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/core/domain/mental_health_tests.dart';
import 'package:loopcare_frontend/core/domain/physical_fitness/physical_fitness.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_type.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_activities_preferences.dart';

part 'account_response.g.dart';

@immutable
@JsonSerializable()
class AccountResponse {
  final int id;
  final int? groupId;
  final String name;
  final String email;
  final String? country;
  final DateTime emailApproveDate;
  final String measurementSystem;
  final bool isConsentApproved;
  final bool isLegalApproved;
  final UserGroupingState groupingState;
  final DateTime? groupingStartedAt;
  final GenderType gender;
  final SexType sex;
  final PhysicalFitness physicalFitness;
  final DiabetesType? diabetes;
  final FoodPreferences? foodPreferences;
  final GroupingPreferences? groupingPreferences;
  final Subscription subscription;
  @JsonKey(unknownEnumValue: UnlockedFeatureType.unknown)
  final List<UnlockedFeatureType> unlockedFeatures;
  final MentalHealthTests? mentalHealthTests;
  final PhysicalActivitiesPreferences? physicalActivitiesPreferences;
  final MedicalOnboarding medicalOnboarding;

  const AccountResponse({
    required this.id,
    required this.groupId,
    required this.name,
    required this.email,
    required this.country,
    required this.emailApproveDate,
    required this.measurementSystem,
    required this.isConsentApproved,
    required this.isLegalApproved,
    required this.gender,
    required this.sex,
    required this.groupingState,
    required this.groupingStartedAt,
    required this.physicalFitness,
    required this.diabetes,
    required this.foodPreferences,
    required this.groupingPreferences,
    required this.unlockedFeatures,
    required this.mentalHealthTests,
    required this.physicalActivitiesPreferences,
    required this.subscription,
    required this.medicalOnboarding,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) => _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}
