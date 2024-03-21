part of 'physical_questions_bloc.dart';

@freezed
class PhysicalQuestionsState with _$PhysicalQuestionsState {
  const PhysicalQuestionsState._();
  
  const factory PhysicalQuestionsState({
    @Default(false) bool isCompletedSuccessfully,
    @Default(false) bool isCompletedWithError,
    String? heightInCm,
    @Default(MeasurementSystemType.metric) MeasurementSystemType heightMeasurementSystemType,
    String? weightInKg,
    @Default(MeasurementSystemType.metric) MeasurementSystemType weightMeasurementSystemType,
    DateTime? birthday,
    @Default(0) int happiness,
    int? age,
    num? bmi,
    SexType? sexType,
    GenderType? genderType,
  }) = _PhysicalQuestionsState;

  factory PhysicalQuestionsState.initial() => const PhysicalQuestionsState();

  RegistrationPhysicalFitnessData get registrationPhysicalQuestionsData {
    return RegistrationPhysicalFitnessData(
      birthday: birthday?.toIso8601String() ?? '',
      bmi: bmi != null ? bmi!.toDouble() : 0,
      height: double.parse(heightInCm!),
      happiness: happiness,
      gender: genderType!.name,
      weight: double.parse(weightInKg!),
      sex: sexType != null
          ? sexType!.name
          : 'preferNotToSay',
    );
  }

  factory PhysicalQuestionsState.fromJson(Map<String, dynamic> json) =>
      _$PhysicalQuestionsStateFromJson(json);
}
