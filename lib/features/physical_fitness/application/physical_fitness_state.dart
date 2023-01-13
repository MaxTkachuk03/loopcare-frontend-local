part of 'physical_fitness_bloc.dart';

@freezed
class PhysicalFitnessState with _$PhysicalFitnessState {
  factory PhysicalFitnessState.initial() => PhysicalFitnessState(
        currentQuestion: PhysicalFitnessQuestions.values[0],
      );

  const factory PhysicalFitnessState({
    required PhysicalFitnessQuestions currentQuestion,
    @Default(false) bool isCompletedSuccessfully,
    @Default(false) bool isCompletedWithError,
    String? height,
    @Default(MeasurementSystemType.metric)
        MeasurementSystemType heightMeasurementSystemType,
    String? weight,
    @Default(MeasurementSystemType.metric)
        MeasurementSystemType weightMeasurementSystemType,
    DateTime? birthday,
    SexType? sexType,
    BiologicalGenderType? biologicalGenderType,
  }) = _PhysicalFitnessState;

  factory PhysicalFitnessState.fromJson(Map<String, dynamic> json) =>
      _$PhysicalFitnessStateFromJson(json);
}
