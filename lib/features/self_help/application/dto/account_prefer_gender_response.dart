import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_prefer_gender_response.g.dart';

@immutable
@JsonSerializable()
class AccountPreferGenderResponse {
  final int id;
  final String name;

  const AccountPreferGenderResponse({
    required this.id,
    required this.name,
  });

  static AccountPreferGenderResponse fromJson(Map<String, dynamic> json) =>
      _$AccountPreferGenderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountPreferGenderResponseToJson(this);
}
