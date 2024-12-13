import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@immutable
@JsonSerializable()
class ForgotPasswordResponse {
  final List<String>? message;

  const ForgotPasswordResponse(
    this.message,
  );

  static ForgotPasswordResponse fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
