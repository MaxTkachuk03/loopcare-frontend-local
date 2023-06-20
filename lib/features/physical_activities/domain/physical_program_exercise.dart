import 'package:freezed_annotation/freezed_annotation.dart';

part 'physical_program_exercise.freezed.dart';

part 'physical_program_exercise.g.dart';

@freezed
class PhysicalProgramExercise with _$PhysicalProgramExercise {
  const PhysicalProgramExercise._();

  const factory PhysicalProgramExercise({
    @Default('') String name,
    @Default('') String? image,
    @Default('') String? video,
    @Default(0) int order,
    @Default(0) int duration,
    @Default(0) int delayBeforeNext,
    @Default(0) int explanationSkipTime,
  }) = _PhysicalProgramExercise;

  factory PhysicalProgramExercise.fromJson(Map<String, dynamic> json) =>
      _$PhysicalProgramExerciseFromJson(json);
}
