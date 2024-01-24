import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/sex_type.dart';

part 'login_response.g.dart';

@immutable
@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String name;
  final String email;
  final String? country;
  final SexType gender;
  final String bioGender;
  final DateTime emailApproveDate;
  final Subscription subscription;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.gender,
    required this.bioGender,
    required this.emailApproveDate,
    required this.subscription,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
