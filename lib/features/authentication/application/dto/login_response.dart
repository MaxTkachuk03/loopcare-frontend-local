import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse {
  final String accessToken;
  final String refreshToken;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
