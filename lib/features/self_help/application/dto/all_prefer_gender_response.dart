import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/prefer_gender.dart';

part 'all_prefer_gender_response.g.dart';

@immutable
@JsonSerializable()
class AllPreferGenderResponse {

  final List<PreferGender> data;

  const AllPreferGenderResponse(this.data);

  static AllPreferGenderResponse fromJson(Map<String, dynamic> json) =>
      _$AllPreferGenderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllPreferGenderResponseToJson(this);
}
