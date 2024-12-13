import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'physical_activities_preferences_response.g.dart';

@immutable
@JsonSerializable()
class PhysicalActivitiesPreferencesResponse {
  final String? trainingFrequency;
  final String? trainingTargets;
  final bool? flexible;

  const PhysicalActivitiesPreferencesResponse({
    required this.trainingFrequency,
    required this.trainingTargets,
    required this.flexible,
  });

  static PhysicalActivitiesPreferencesResponse fromJson(Map<String, dynamic> json) =>
      _$PhysicalActivitiesPreferencesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhysicalActivitiesPreferencesResponseToJson(this);
}
