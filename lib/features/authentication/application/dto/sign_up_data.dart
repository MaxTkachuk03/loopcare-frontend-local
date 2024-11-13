import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/medical_onboarding.dart';
import 'package:loopcare_frontend/features/authentication/application/dto/mental_health_test_answers.dart';

part 'sign_up_data.g.dart';

@immutable
@JsonSerializable()
class SignUpData {
  final String customerIoId;
  final String name;
  final String email;
  final String password;
  final bool isConsentApproved;
  final bool isLegalApproved;
  final bool consentToEmail;
  final bool enablePushNotifications;

  final int happiness;
  final double height;
  final double weight;
  final double bmi;
  final String birthDate;
  final String gender;
  final String sex;

  final MentalHealthTestAnswer mentalHealthTest;
  final MedicalOnboarding medicalOnboarding;

  const SignUpData({
    required this.customerIoId,
    required this.name,
    required this.email,
    required this.password,
    required this.isConsentApproved,
    required this.isLegalApproved,
    required this.consentToEmail,
    required this.enablePushNotifications,
    required this.happiness,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.birthDate,
    required this.gender,
    required this.sex,
    required this.mentalHealthTest,
    required this.medicalOnboarding,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => _$SignUpDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpDataToJson(this);
}
