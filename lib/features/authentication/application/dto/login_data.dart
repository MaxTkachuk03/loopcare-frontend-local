import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_data.g.dart';

@immutable
@JsonSerializable()
class LoginData {
  final String email;
  final String password;

  const LoginData({
    required this.email,
    required this.password,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
