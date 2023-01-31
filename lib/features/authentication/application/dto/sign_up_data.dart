import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_data.g.dart';

@immutable
@JsonSerializable()
class SignUpData {
  final String name;
  final String email;
  final String password;
  final bool isConsentApproved;
  final bool isLegalApproved;

  const SignUpData({
    required this.name,
    required this.email,
    required this.password,
    required this.isConsentApproved,
    required this.isLegalApproved,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => _$SignUpDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpDataToJson(this);
}
