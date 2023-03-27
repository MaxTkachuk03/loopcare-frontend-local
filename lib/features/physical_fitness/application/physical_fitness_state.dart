part of 'physical_fitness_bloc.dart';

@freezed
class PhysicalFitnessState with _$PhysicalFitnessState {
  const PhysicalFitnessState._();

  factory PhysicalFitnessState.initial() => PhysicalFitnessState(
        currentQuestion: PhysicalFitnessQuestions.values[0],
      );

  const factory PhysicalFitnessState({
    required PhysicalFitnessQuestions currentQuestion,
    @Default(false) bool isCompletedSuccessfully,
    @Default(false) bool isCompletedWithError,
    String? heightInCm,
    @Default(MeasurementSystemType.metric)
        MeasurementSystemType heightMeasurementSystemType,
    String? weightInKg,
    @Default(MeasurementSystemType.metric)
        MeasurementSystemType weightMeasurementSystemType,
    DateTime? birthday,
    int? age,
    num? bmi,
    SexType? sexType,
    BiologicalGenderType? biologicalGenderType,
  }) = _PhysicalFitnessState;

  RegistrationPhysicalFitnessData get registrationPhysicalFitnessData =>
      RegistrationPhysicalFitnessData(
        birthday: birthday?.toIso8601String() ?? '',
        bmi: bmi as int,
        height: int.parse(heightInCm ?? '0'),
        gender: describeEnum(sexType as SexType),
        weight: int.parse(weightInKg ?? '0'),
        bioGender: describeEnum(biologicalGenderType as BiologicalGenderType),
      );

  factory PhysicalFitnessState.fromJson(Map<String, dynamic> json) =>
      _$PhysicalFitnessStateFromJson(json);
}
