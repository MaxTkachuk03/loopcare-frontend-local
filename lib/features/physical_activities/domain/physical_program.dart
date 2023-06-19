import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_assessment.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_difficulty.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_place.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_type.dart';

part 'physical_program.freezed.dart';

part 'physical_program.g.dart';

@freezed
abstract class PhysicalProgram implements _$PhysicalProgram {
  const PhysicalProgram._();

  const factory PhysicalProgram({
    required int id,
    required String name,
    required int duration,
    required String programDescription,
    required String targetMuscles,
    required String equipment,
    required bool isCustom,
    required ProgramType type,
    required ProgramPlace place,
    required ProgramDifficulty difficulty,
    required List<PhysicalProgramExercise> exercises,
    required PhysicalProgramAssessment? assessment,
  }) = _PhysicalProgram;

  factory PhysicalProgram.fromJson(Map<String, dynamic> json) => _$PhysicalProgramFromJson(json);
}
