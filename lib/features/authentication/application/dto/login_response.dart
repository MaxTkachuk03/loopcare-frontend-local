import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/core/domain/user/user.dart';

part 'login_response.g.dart';

@immutable
@JsonSerializable()
class LoginResponse {
  final User user;

  const LoginResponse(this.user);

  static LoginResponse fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
