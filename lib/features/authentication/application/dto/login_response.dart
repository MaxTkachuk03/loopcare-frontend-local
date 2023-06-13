import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

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
  final bool isPreferencesComplete;
  final String gender;
  final String bioGender;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.isPreferencesComplete,
    required this.gender,
    required this.bioGender,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
