part of 'education_program_bloc.dart';

@freezed
class EducationProgramEvent with _$EducationProgramEvent {
  const factory EducationProgramEvent.getLessons(LessonCategory category) =
      _GetLessons;
}
