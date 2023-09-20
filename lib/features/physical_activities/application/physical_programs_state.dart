part of 'physical_programs_bloc.dart';

@freezed
class PhysicalProgramsState with _$PhysicalProgramsState {
  const factory PhysicalProgramsState.initial(PhysicalProgramsData data) = Initial;

  const factory PhysicalProgramsState.loading(PhysicalProgramsData data) = Loading;

  const factory PhysicalProgramsState.programLoaded(PhysicalProgramsData data) = ProgramLoaded;

  const factory PhysicalProgramsState.error(PhysicalProgramsData data) = Error;

  const factory PhysicalProgramsState.programUpdated(PhysicalProgramsData data) = ProgramUpdated;

  const PhysicalProgramsState._();

  List<PhysicalProgram> get getAlternativePrograms {
    return maybeWhen(
        orElse: () => [],
        programLoaded: (state) {
          var neededProgram = state.allPrograms.toList();
          for (var elem in getSelectedPrograms) {
            neededProgram.remove(elem);
          }
          return neededProgram;
        });
  }

  List<PhysicalProgram> get getSelectedPrograms {
    return maybeWhen(
        orElse: () => [],
        programLoaded: (state) {
          return state.allPrograms
              .where(
                (element) =>
                    element.type == state.programType &&
                    element.place == state.programPlace &&
                    element.difficulty == state.programDifficulty,
              )
              .toList();
        });
  }
}

@freezed
class PhysicalProgramsData with _$PhysicalProgramsData {
  const PhysicalProgramsData._();

  const factory PhysicalProgramsData({
    @Default([]) List<PhysicalProgram> allPrograms,
    PhysicalProgram? currentProgram,
    @Default(ProgramType.strength) ProgramType programType,
    @Default(ProgramPlace.outdoor) ProgramPlace programPlace,
    @Default(ProgramDifficulty.easy) ProgramDifficulty programDifficulty,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _PhysicalProgramsData;
}
