import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/account/gender_type.dart';
import 'package:loopcare_frontend/core/domain/account/sex_type.dart';
import 'package:loopcare_frontend/features/authentication/domain/subscription/subscription.dart';

part 'login_response.g.dart';

@immutable
@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String? customerIoId;
  final String refreshToken;
  final int id;
  final String name;
  final String email;
  final String? country;
  final GenderType gender;
  final SexType sex;
  final Subscription subscription;
  final DateTime? emailApproveDate;
  final DateTime createdAt;
  final String? avatarUrl;
  final Map<String, bool> features;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.customerIoId,
    required this.name,
    required this.email,
    required this.country,
    required this.gender,
    required this.sex,
    required this.subscription,
    required this.emailApproveDate,
    required this.createdAt,
    required this.avatarUrl,
    required this.features,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
