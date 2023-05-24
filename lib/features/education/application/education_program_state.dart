part of 'education_program_bloc.dart';

@freezed
class EducationProgramState with _$EducationProgramState {
  const factory EducationProgramState.initial(EducationProgramData data) =
      _Initial;

  const factory EducationProgramState.educationProgram(
      EducationProgramData data) = _EducationProgram;

  const factory EducationProgramState.loading(EducationProgramData data) =
      _Loading;

  const factory EducationProgramState.error(EducationProgramData data) = _Error;
}

@freezed
class EducationProgramData with _$EducationProgramData {
  const factory EducationProgramData({
    @Default([]) List<EducationLesson> lessons,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _EducationProgramData;
}
