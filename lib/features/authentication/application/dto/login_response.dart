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

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.name,
    required this.email,
    required this.country,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
