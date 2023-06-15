part of 'physical_programs_bloc.dart';

@freezed
class PhysicalProgramsState with _$PhysicalProgramsState {
  factory PhysicalProgramsState.initial() => const PhysicalProgramsState(
        programs: [],
        programType: ProgramType.strength,
        programPlace: ProgramPlace.home,
        programDifficulty: ProgramDifficulty.easy,
      );

  const factory PhysicalProgramsState({
    required List<PhysicalProgram> programs,
    required ProgramType programType,
    required ProgramPlace programPlace,
    required ProgramDifficulty programDifficulty,
  }) = _PhysicalProgramsState;

  const PhysicalProgramsState._();
}
