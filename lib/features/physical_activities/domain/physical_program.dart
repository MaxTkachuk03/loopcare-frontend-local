import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_assessment.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_difficulty.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_place.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_type.dart';

part 'physical_program.freezed.dart';

part 'physical_program.g.dart';

@freezed
class PhysicalProgram with _$PhysicalProgram {
  const PhysicalProgram._();

  const factory PhysicalProgram.basic({
    required int id,
    required String name,
    @Default(0) int duration,
    @Default('') String programDescription,
    @Default('') String targetMuscles,
    @Default('') String equipment,
    @Default(false) bool isCustom,
    @Default(ProgramType.strength) ProgramType type,
    @Default(ProgramPlace.outdoor) ProgramPlace place,
    @Default(ProgramDifficulty.easy) ProgramDifficulty difficulty,
    required List<PhysicalProgramExercise> exercises,
    required PhysicalProgramAssessment? assessment,
  }) = PhysicalProgramBasic;

  const factory PhysicalProgram.placeholder({required String name}) = PhysicalProgramPlaceholder;

  List<PhysicalProgramExercise> get exercises => map(basic: (s) => s.exercises, placeholder: (_) => []);

  String get typeName => map(basic: (s) => s.type.name, placeholder: (_) => '');

  String get difficultyName => map(basic: (s) => s.difficulty.name, placeholder: (_) => '');

  String get placeName => map(basic: (s) => s.place.name, placeholder: (_) => '');

  String get equipment => map(basic: (s) => s.equipment, placeholder: (_) => '');

  String get targetMuscles => map(basic: (s) => s.targetMuscles, placeholder: (_) => '');

  int get duration => map(basic: (s) => s.duration, placeholder: (_) => 0);

  String get programDescription => map(basic: (s) => s.programDescription, placeholder: (_) => '');

  PhysicalProgramAssessment? get assessment => map(basic: (s) => s.assessment, placeholder: (_) => null);

  int get id => map(basic: (s) => s.id, placeholder: (_) => 0);

  factory PhysicalProgram.fromJson(Map<String, dynamic> json) => _$PhysicalProgramFromJson(json);
}
