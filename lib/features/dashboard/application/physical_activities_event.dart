part of 'physical_activities_bloc.dart';

@freezed
class PhysicalActivitiesEvent with _$PhysicalActivitiesEvent {
  const factory PhysicalActivitiesEvent.getWeeklyPhysicalActivities() = _GetWeeklyPhysicalActivities;
}
