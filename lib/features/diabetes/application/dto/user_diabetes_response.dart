import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_diabetes_response.g.dart';

@immutable
@JsonSerializable()
class UserDiabetesResponse {
  final int id;
  final String name;

  const UserDiabetesResponse({
    required this.id,
    required this.name,
  });

  static UserDiabetesResponse fromJson(Map<String, dynamic> json) =>
      _$UserDiabetesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDiabetesResponseToJson(this);
}
