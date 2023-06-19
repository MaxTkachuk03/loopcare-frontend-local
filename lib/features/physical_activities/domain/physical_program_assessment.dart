import 'package:freezed_annotation/freezed_annotation.dart';

part 'physical_program_assessment.freezed.dart';

part 'physical_program_assessment.g.dart';

@freezed
abstract class PhysicalProgramAssessment implements _$PhysicalProgramAssessment {
  const PhysicalProgramAssessment._();

  const factory PhysicalProgramAssessment({
    required int score,
    required bool like,
    required DateTime completedAt,
  }) = _PhysicalProgramAssessment;

  factory PhysicalProgramAssessment.fromJson(Map<String, dynamic> json) => _$PhysicalProgramAssessmentFromJson(json);
}
