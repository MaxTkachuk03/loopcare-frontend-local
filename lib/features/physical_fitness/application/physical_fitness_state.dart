part of 'physical_fitness_bloc.dart';

@freezed
class PhysicalFitnessState with _$PhysicalFitnessState {
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
  const PhysicalFitnessState._();

  factory PhysicalFitnessState.initial() => PhysicalFitnessState(
        currentQuestion: PhysicalFitnessQuestions.values[0],
      );

  RegistrationPhysicalFitnessData get registrationPhysicalFitnessData {
    return RegistrationPhysicalFitnessData(
      birthday: birthday?.toIso8601String() ?? '',
      bmi: bmi != null ? bmi!.toDouble() : 0,
      height: double.parse(heightInCm ?? '0'),
      gender: describeEnum(sexType as SexType),
      weight: double.parse(weightInKg ?? '0'),
      bioGender: biologicalGenderType != null
          ? describeEnum(biologicalGenderType as BiologicalGenderType)
          : 'preferNotToSay',
    );
  }

  factory PhysicalFitnessState.fromJson(Map<String, dynamic> json) =>
      _$PhysicalFitnessStateFromJson(json);
}
