part of 'physical_activities_bloc.dart';

@freezed
class PhysicalActivitiesState with _$PhysicalActivitiesState {
  const factory PhysicalActivitiesState.initial(PhysicalActivitiesData data) = Initial;

  const factory PhysicalActivitiesState.loading(PhysicalActivitiesData data) = Loading;

  const factory PhysicalActivitiesState.activitiesLoaded(PhysicalActivitiesData data) = ActivitiesLoaded;

  const factory PhysicalActivitiesState.error(PhysicalActivitiesData data) = Error;
}

@freezed
class PhysicalActivitiesData with _$PhysicalActivitiesData {
  const PhysicalActivitiesData._();

  const factory PhysicalActivitiesData({
    @Default([]) List<PhysicalProgram> weeklyActivities,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _PhysicalActivitiesData;

  int get amountWeeklyFinishedActivities {
    return weeklyActivities.length;
  }

  List<PhysicalProgram> get activities {
    // Adding placeholder activities if there are less than 3 already logged
    final activities = [...weeklyActivities];

    if (weeklyActivities.length < 3) {
      for (var i = weeklyActivities.length; i < 3; i++) {
        activities.add(PhysicalProgram.placeholder(name: 'To do:  Activity $i'));
      }
    }

    return activities;
  }
}
