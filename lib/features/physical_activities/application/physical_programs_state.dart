part of 'physical_programs_bloc.dart';

@freezed
class PhysicalProgramsState with _$PhysicalProgramsState {
  const factory PhysicalProgramsState.initial(PhysicalProgramsData data) = Initial;

  const factory PhysicalProgramsState.loading(PhysicalProgramsData data) = Loading;

  const factory PhysicalProgramsState.programLoaded(PhysicalProgramsData data) = ProgramLoaded;

  const factory PhysicalProgramsState.error(PhysicalProgramsData data) = Error;

  const factory PhysicalProgramsState.programUpdated(PhysicalProgramsData data) = ProgramUpdated;

  const PhysicalProgramsState._();
}

@freezed
class PhysicalProgramsData with _$PhysicalProgramsData {
  const PhysicalProgramsData._();

  const factory PhysicalProgramsData({
    @Default([]) List<PhysicalProgram> allPrograms,
    PhysicalProgram? currentProgram,
    ProgramType? programType,
    ProgramPlace? programPlace,
    ProgramDifficulty? programDifficulty,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _PhysicalProgramsData;

  List<PhysicalProgram> get getAlternativePrograms {
    var neededProgram = allPrograms.toList();

    for (var elem in getSelectedPrograms) {
      neededProgram.remove(elem);
    }

    return neededProgram;
  }

  List<PhysicalProgram> get getSelectedPrograms {
    return allPrograms
        .where(
          (element) =>
              element.type == programType &&
              element.place == programPlace &&
              element.difficulty == programDifficulty,
        )
        .toList();
  }
}
