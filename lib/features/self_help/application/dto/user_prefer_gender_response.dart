import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_prefer_gender_response.g.dart';

@immutable
@JsonSerializable()
class UserPreferGenderResponse {
  final int id;
  final String name;

  const UserPreferGenderResponse({
    required this.id,
    required this.name,
  });

  static UserPreferGenderResponse fromJson(Map<String, dynamic> json) =>
      _$UserPreferGenderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferGenderResponseToJson(this);
}
