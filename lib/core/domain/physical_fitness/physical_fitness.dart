import 'package:freezed_annotation/freezed_annotation.dart';

part 'physical_fitness.freezed.dart';

part 'physical_fitness.g.dart';

@freezed
abstract class PhysicalFitness implements _$PhysicalFitness {
  const PhysicalFitness._();

  const factory PhysicalFitness({
    required int id,
    required double height,
    required double bmi,
    required DateTime birthDate,
    DateTime? createdAt,
  }) = _PhysicalFitness;

  factory PhysicalFitness.fromJson(Map<String, dynamic> json) => _$PhysicalFitnessFromJson(json);
}
