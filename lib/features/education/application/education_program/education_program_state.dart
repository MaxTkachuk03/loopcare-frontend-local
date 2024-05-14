part of 'education_program_bloc.dart';

@freezed
class EducationProgramState with _$EducationProgramState {
  const factory EducationProgramState.initial(EducationProgramData data) = EducationProgramStateInitial;

  const factory EducationProgramState.educationProgram(EducationProgramData data) = GotLessonsState;

  const factory EducationProgramState.loading(EducationProgramData data) = EducationProgramStateLoading;

  const factory EducationProgramState.loaded(EducationProgramData data) = EducationProgramStateLoaded;

  const factory EducationProgramState.error(EducationProgramData data) = EducationProgramStateError;
}

@freezed
class EducationProgramData with _$EducationProgramData {
  const EducationProgramData._();

  const factory EducationProgramData({
    @Default([]) List<EducationLesson> lessons,
    LessonWithCountdown? lessonWithCountdown,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _EducationProgramData;

  int get activeLessonIndex => lessons.indexWhere((element) => !element.isCompleted && !element.isLocked);

  String getLessonCardImage(int id) => lessons.firstWhere((lesson) => lesson.id == id).cardImage;
}
