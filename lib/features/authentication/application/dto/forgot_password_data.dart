import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_data.g.dart';

@immutable
@JsonSerializable()
class ForgotPasswordData {
  final String email;

  const ForgotPasswordData({
    required this.email,
  });

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordDataFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordDataToJson(this);
}
