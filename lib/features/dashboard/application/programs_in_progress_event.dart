part of 'programs_in_progress_bloc.dart';

@freezed
class ProgramsInProgressEvent with _$ProgramsInProgressEvent {
  const factory ProgramsInProgressEvent.setProgram(PhysicalProgram program) = SetProgram;

  const factory ProgramsInProgressEvent.removeProgram(int id) = RemoveProgram;

  const factory ProgramsInProgressEvent.removeExpiredPrograms() = RemoveExpiredPrograms;
}
