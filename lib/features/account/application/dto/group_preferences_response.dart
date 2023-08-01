import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/physical_fitness/domain/gender_preferences.dart';

part 'group_preferences_response.g.dart';

@immutable
@JsonSerializable()
class GroupPreferencesResponse {
  final GenderPreferences? genderPreference;
  final String bmiRange;
  final String ageRange;
  final String? timezone;
  final String? nickname;

  const GroupPreferencesResponse(
    this.genderPreference,
    this.bmiRange,
    this.ageRange,
    this.timezone,
    this.nickname,
  );

  static GroupPreferencesResponse fromJson(Map<String, dynamic> json) =>
      _$GroupPreferencesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPreferencesResponseToJson(this);
}
