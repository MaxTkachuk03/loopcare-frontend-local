import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_physical_fitness_data.freezed.dart';

part 'registration_physical_fitness_data.g.dart';

@freezed
abstract class RegistrationPhysicalFitnessData
    implements _$RegistrationPhysicalFitnessData {
  const RegistrationPhysicalFitnessData._();

  const factory RegistrationPhysicalFitnessData({
    required final int height,
    required final int weight,
    required final int bmi,
    required final String birthday,
    required final String gender,
    required final String bioGender,
  }) = _RegistrationPhysicalFitnessData;

  factory RegistrationPhysicalFitnessData.fromJson(Map<String, dynamic> json) =>
      _$RegistrationPhysicalFitnessDataFromJson(json);
}
