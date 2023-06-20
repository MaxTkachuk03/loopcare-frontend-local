import 'package:freezed_annotation/freezed_annotation.dart';

part 'physical_program_exercise.freezed.dart';

part 'physical_program_exercise.g.dart';

@freezed
abstract class PhysicalProgramExercise implements _$PhysicalProgramExercise {
  const PhysicalProgramExercise._();

  const factory PhysicalProgramExercise({
    required String name,
    required String? image,
    required String? video,
    required int order,
    required int duration,
    required int delayBeforeNext,
    required int explanationSkipTime,
  }) = _PhysicalProgramExercise;

  factory PhysicalProgramExercise.fromJson(Map<String, dynamic> json) =>
      _$PhysicalProgramExerciseFromJson(json);
}
