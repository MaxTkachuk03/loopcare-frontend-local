import 'package:freezed_annotation/freezed_annotation.dart';

part 'physical_activities_preferences_body.freezed.dart';

part 'physical_activities_preferences_body.g.dart';

@freezed
abstract class PhysicalActivitiesPreferencesBody implements _$PhysicalActivitiesPreferencesBody {
  const PhysicalActivitiesPreferencesBody._();

  const factory PhysicalActivitiesPreferencesBody({
    required String trainingFrequency,
    String? trainingTargets,
    bool? flexible,
  }) = _PhysicalActivitiesPreferencesBody;

  factory PhysicalActivitiesPreferencesBody.fromJson(Map<String, dynamic> json) =>
      _$PhysicalActivitiesPreferencesBodyFromJson(json);
}
