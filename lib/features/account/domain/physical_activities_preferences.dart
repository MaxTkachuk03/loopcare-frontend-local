import 'package:freezed_annotation/freezed_annotation.dart';

part 'physical_activities_preferences.freezed.dart';

part 'physical_activities_preferences.g.dart';

@freezed
class PhysicalActivitiesPreferences with _$PhysicalActivitiesPreferences {
  const PhysicalActivitiesPreferences._();

  const factory PhysicalActivitiesPreferences({
    required String trainingFrequency,
    required String trainingTargets,
    required bool flexible,
  }) = _PhysicalActivitiesPreferences;

  factory PhysicalActivitiesPreferences.fromJson(Map<String, dynamic> json) => _$PhysicalActivitiesPreferencesFromJson(json);
}