import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _PhysicalProgram;

  factory PhysicalProgram.fromJson(Map<String, dynamic> json) => _$PhysicalProgramFromJson(json);
}
