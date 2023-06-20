part of 'physical_programs_bloc.dart';

@freezed
class PhysicalProgramsState with _$PhysicalProgramsState {
  const factory PhysicalProgramsState.initial(PhysicalProgramsData data) = Initial;

  const factory PhysicalProgramsState.loading(PhysicalProgramsData data) = Loading;

  const factory PhysicalProgramsState.programLoaded(PhysicalProgramsData data) = ProgramLoaded;

  const factory PhysicalProgramsState.programFilterSet(PhysicalProgramsData data) = ProgramFilterSet;

  const factory PhysicalProgramsState.errorLoadingPrograms(PhysicalProgramsData data) = ErrorLoadingPrograms;

  const factory PhysicalProgramsState.customProgramLogged(PhysicalProgramsData data) = CustomProgramLogged;

  const factory PhysicalProgramsState.calendarProgramsLoaded(PhysicalProgramsData data) =
      CalendarProgramsLoaded;

  const factory PhysicalProgramsState.calendarProgramsError(PhysicalProgramsData data) =
      CalendarProgramsError;

  const PhysicalProgramsState._();
}

@freezed
class PhysicalProgramsData with _$PhysicalProgramsData {
  const PhysicalProgramsData._();

  const factory PhysicalProgramsData({
    @Default([]) List<PhysicalProgram> programs,
    PhysicalProgram? currentProgram,
    @Default([]) List<PhysicalProgram> weeklyActivities,
    @Default(ProgramType.strength) ProgramType programType,
    @Default(ProgramPlace.home) ProgramPlace programPlace,
    @Default(ProgramDifficulty.easy) ProgramDifficulty programDifficulty,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _PhysicalProgramsData;

  int get amountWeeklyFinishedActivities {
    return weeklyActivities.length;
  }

  List<PhysicalProgram> get activities {
    // Adding placeholder activities if there are less than 3 already logged
    final activities = [...weeklyActivities];

    if (weeklyActivities.length < 3) {
      for (var i = weeklyActivities.length; i < 3; i++) {
        activities.add(PhysicalProgram.dashboardPlaceholder(name: 'To do:  Activity $i'));
      }
    }

    return activities;
  }
}
