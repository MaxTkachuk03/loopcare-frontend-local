import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_response.g.dart';

@immutable
@JsonSerializable()
class AccountResponse {
  final int id;
  final String name;
  final String email;
  final String? country;
  final bool isPreferencesComplete;

  const AccountResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.isPreferencesComplete,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}
