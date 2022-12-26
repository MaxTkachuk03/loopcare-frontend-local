part of 'physical_fitness_bloc.dart';

@freezed
class PhysicalFitnessState with _$PhysicalFitnessState {
  factory PhysicalFitnessState.initial() => PhysicalFitnessState(
        currentQuestion: PhysicalFitnessQuestions.values[0],
      );

  const factory PhysicalFitnessState({
    required PhysicalFitnessQuestions currentQuestion,
    @Default(false) bool isCompleted,
  }) = _PhysicalFitnessState;

  factory PhysicalFitnessState.fromJson(Map<String, dynamic> json) =>
      _$PhysicalFitnessStateFromJson(json);
}
