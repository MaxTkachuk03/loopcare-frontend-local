import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/prefer_gender.dart';

part 'user_prefer_gender_response.g.dart';

@immutable
@JsonSerializable()
class UserPreferGenderResponse {
  final PreferGender data;

  const UserPreferGenderResponse(this.data);

  static UserPreferGenderResponse fromJson(Map<String, dynamic> json) =>
      _$UserPreferGenderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferGenderResponseToJson(this);
}
