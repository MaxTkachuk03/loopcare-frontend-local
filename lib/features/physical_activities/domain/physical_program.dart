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
    String? image,
    @Default(ProgramType.strength) ProgramType type,
    @Default(ProgramPlace.outdoor) ProgramPlace place,
    @Default(ProgramDifficulty.easy) ProgramDifficulty difficulty,
    required List<PhysicalProgramExercise> exercises,
    required PhysicalProgramAssessment? assessment,
  }) = PhysicalProgramBasic;

  const factory PhysicalProgram.placeholder({required String name}) = PhysicalProgramPlaceholder;

  const factory PhysicalProgram.programInProgress(
      {required int id,
      required String name,
      required String startDate}) = PhysicalProgramInProgress;

  int get id => maybeMap(basic: (s) => s.id, orElse: () => 0);

  int get duration => maybeMap(basic: (s) => s.duration, orElse: () => 0);

  ProgramType? get type => mapOrNull(basic: (s) => s.type);

  ProgramDifficulty? get difficulty => mapOrNull(basic: (s) => s.difficulty);

  ProgramPlace? get place => mapOrNull(basic: (s) => s.place);

  String get typeName => maybeMap(basic: (s) => s.type.name, orElse: () => '');

  String get difficultyName => maybeMap(basic: (s) => s.difficulty.name, orElse: () => '');

  String get placeName => maybeMap(basic: (s) => s.place.name, orElse: () => '');

  String get equipment => maybeMap(basic: (s) => s.equipment, orElse: () => '');

  String? get image => maybeMap(basic: (s) => s.image, orElse: () => null);

  String get targetMuscles => maybeMap(basic: (s) => s.targetMuscles, orElse: () => '');

  String get programDescription => maybeMap(basic: (s) => s.programDescription, orElse: () => '');

  String get startDate => maybeMap(basic: (s) => s.startDate, orElse: () => '');

  PhysicalProgramAssessment? get assessment =>
      maybeMap(basic: (s) => s.assessment, orElse: () => null);

  List<PhysicalProgramExercise> get exercises =>
      maybeMap(basic: (s) => s.exercises, orElse: () => []);

  factory PhysicalProgram.fromJson(Map<String, dynamic> json) => _$PhysicalProgramFromJson(json);
}
