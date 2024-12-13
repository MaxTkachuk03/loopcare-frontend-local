part of 'physical_programs_bloc.dart';

@freezed
class PhysicalProgramsEvent with _$PhysicalProgramsEvent {
  const factory PhysicalProgramsEvent.init() = _Init;

  const factory PhysicalProgramsEvent.getAllPrograms() = _GetAllPrograms;

  const factory PhysicalProgramsEvent.createCustomActivity(String name) = _CreateCustomActivity;

  const factory PhysicalProgramsEvent.setProgramType(ProgramType programType) = _SetProgramType;

  const factory PhysicalProgramsEvent.setProgramPlace(ProgramPlace programPlace) = _SetProgramPlace;

  const factory PhysicalProgramsEvent.setCurrentProgram(PhysicalProgram? program) =
      _SetCurrentProgram;

  const factory PhysicalProgramsEvent.setProgramDifficulty(ProgramDifficulty programDifficulty) =
      _SetProgramDifficulty;

  const factory PhysicalProgramsEvent.logAssessment(int score, bool like) = _LogAssessment;
}
