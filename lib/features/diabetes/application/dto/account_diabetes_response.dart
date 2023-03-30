import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_diabetes_response.g.dart';

@immutable
@JsonSerializable()
class AccountDiabetesResponse {
  final int id;
  final String name;

  const AccountDiabetesResponse({
    required this.id,
    required this.name,
  });

  static AccountDiabetesResponse fromJson(Map<String, dynamic> json) =>
      _$AccountDiabetesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDiabetesResponseToJson(this);
}
