part of 'dashboard_education_bloc.dart';

@freezed
class DashboardEducationEvent with _$DashboardEducationEvent {
  const factory DashboardEducationEvent.getDashboardLessons({
    DateTime? currentDate,
  }) = _GetDashboardLessons;
}
