part of 'education_program_bloc.dart';

@freezed
class EducationProgramEvent with _$EducationProgramEvent {
  const factory EducationProgramEvent.getLessons() = _GetLessons;

  const factory EducationProgramEvent.resetLessonWithCountdown() = _ResetLessonWithCountdown;

  const factory EducationProgramEvent.setLessonWithCountdown() = _SetLessonWithCountdown;
}
