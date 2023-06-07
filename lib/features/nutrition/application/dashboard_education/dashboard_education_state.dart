part of 'dashboard_education_bloc.dart';

@freezed
class DashboardEducationState with _$DashboardEducationState {
  const DashboardEducationState._();

  const factory DashboardEducationState.initial(DashboardEducationData data) =
      _Initial;

  const factory DashboardEducationState.educationProgram(
      DashboardEducationData data) = _EducationProgram;

  const factory DashboardEducationState.loading(DashboardEducationData data) =
      _Loading;

  const factory DashboardEducationState.error(DashboardEducationData data) =
      _Error;

  bool isVisibleOnDashboard(DateTime date) {
    final now = DateTime.now();
    return date.isBefore(now) || date.isAtSameMomentAs(now);
  }
}

@freezed
class DashboardEducationData with _$DashboardEducationData {
  const factory DashboardEducationData({
    @Default({}) Map<String, List<EducationLesson>> completedLessons,
    EducationLesson? nextLesson,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _DashboardEducationData;
}
