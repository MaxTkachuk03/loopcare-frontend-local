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

  const factory PhysicalProgram.basic({
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
  }) = PhysicalProgramBasic;

  List<PhysicalProgramExercise> get exercises => map(basic: (s) => s.exercises, dashboardPlaceholder: (_) => []);

  String get typeName => map(basic: (s) => s.type.name, dashboardPlaceholder: (_) => '');

  String get difficultyName => map(basic: (s) => s.difficulty.name, dashboardPlaceholder: (_) => '');

  String get placeName => map(basic: (s) => s.place.name, dashboardPlaceholder: (_) => '');

  String get equipment => map(basic: (s) => s.equipment, dashboardPlaceholder: (_) => '');

  String get targetMuscles => map(basic: (s) => s.targetMuscles, dashboardPlaceholder: (_) => '');

  int get duration => map(basic: (s) => s.duration, dashboardPlaceholder: (_) => 0);

  String get programDescription => map(basic: (s) => s.programDescription, dashboardPlaceholder: (_) => '');

  PhysicalProgramAssessment? get assessment => map(basic: (s) => s.assessment, dashboardPlaceholder: (_) => null);

  int get id => map(basic: (s) => s.id, dashboardPlaceholder: (_) => 0);

  const factory PhysicalProgram.dashboardPlaceholder({required String name}) = DashboardPlaceholder;

  factory PhysicalProgram.fromJson(Map<String, dynamic> json) => _$PhysicalProgramFromJson(json);
}
