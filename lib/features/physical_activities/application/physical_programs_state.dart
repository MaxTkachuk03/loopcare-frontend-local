part of 'physical_programs_bloc.dart';

@freezed
class PhysicalProgramsState with _$PhysicalProgramsState {
  const factory PhysicalProgramsState.initial(PhysicalProgramsData data) = Initial;

  const factory PhysicalProgramsState.loading(PhysicalProgramsData data) = Loading;

  const factory PhysicalProgramsState.programLoaded(PhysicalProgramsData data) = ProgramLoaded;

  const factory PhysicalProgramsState.programFilterSet(PhysicalProgramsData data) = ProgramFilterSet;

  const factory PhysicalProgramsState.error(PhysicalProgramsData data) = Error;

  const factory PhysicalProgramsState.programUpdated(PhysicalProgramsData data) = ProgramUpdated;

  const PhysicalProgramsState._();
}

@freezed
class PhysicalProgramsData with _$PhysicalProgramsData {
  const PhysicalProgramsData._();

  const factory PhysicalProgramsData({
    @Default([]) List<PhysicalProgram> programs,
    PhysicalProgram? currentProgram,
    @Default(ProgramType.strength) ProgramType programType,
    @Default(ProgramPlace.home) ProgramPlace programPlace,
    @Default(ProgramDifficulty.easy) ProgramDifficulty programDifficulty,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _PhysicalProgramsData;
}
