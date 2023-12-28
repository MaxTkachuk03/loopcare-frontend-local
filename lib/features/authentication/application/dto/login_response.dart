import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/subscription.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/sex_type.dart';

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
  final Subscription subscription;
  final DateTime emailApproveDate;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.gender,
    required this.bioGender,
    required this.subscription,
    required this.emailApproveDate,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
