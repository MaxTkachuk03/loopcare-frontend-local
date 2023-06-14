import 'package:freezed_annotation/freezed_annotation.dart';

part 'physical_program_assessment.freezed.dart';

part 'physical_program_assessment.g.dart';

@freezed
abstract class PhysicalProgramAssessment implements _$PhysicalProgramAssessment {
  const PhysicalProgramAssessment._();

  const factory PhysicalProgramAssessment({
    required String name,
    required String? image,
    required String? video,
    required int order,
    required int duration,
    required DateTime visitation,
  }) = _PhysicalProgramAssessment;

  factory PhysicalProgramAssessment.fromJson(Map<String, dynamic> json) => _$PhysicalProgramAssessmentFromJson(json);
}
