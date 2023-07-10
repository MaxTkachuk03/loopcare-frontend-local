part of 'programs_in_progress_bloc.dart';

@freezed
class ProgramsInProgressState with _$ProgramsInProgressState {
  const ProgramsInProgressState._();

  factory ProgramsInProgressState.initial() => const ProgramsInProgressState(programs: {});

  const factory ProgramsInProgressState({
    required Map<String, PhysicalProgram> programs,
  }) = _ProgramsInProgressState;

  List<PhysicalProgram> get programsList {
    DateTime threshold = DateTime.now().subtract(const Duration(minutes: 1));

    List<PhysicalProgram> filteredRecords =
        programs.values.where((p) => DateTime.parse(p.startDate).isAfter(threshold)).toList();

    return filteredRecords;
  }

  factory ProgramsInProgressState.fromJson(Map<String, dynamic> json) =>
      _$ProgramsInProgressStateFromJson(json);
}
