import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_assessment.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program_exercise.dart';

part 'physical_program_response.g.dart';

@immutable
@JsonSerializable()
class PhysicalProgramResponse {
  final int id;
  final String name;
  final int? duration;
  final String? programDescription;
  final String? targetMuscles;
  final String? equipment;
  final bool isCustom;
  final String? type;
  final String? place;
  final String? difficulty;
  final List<PhysicalProgramExercise> exercises;
  final PhysicalProgramAssessment assessment;

  const PhysicalProgramResponse({
    required this.id,
    required this.name,
    required this.duration,
    required this.programDescription,
    required this.targetMuscles,
    required this.equipment,
    required this.isCustom,
    required this.type,
    required this.place,
    required this.difficulty,
    required this.exercises,
    required this.assessment,
  });

  static PhysicalProgramResponse fromJson(Map<String, dynamic> json) =>
      _$PhysicalProgramResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhysicalProgramResponseToJson(this);
}
