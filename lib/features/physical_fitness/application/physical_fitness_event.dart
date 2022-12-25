part of 'physical_fitness_bloc.dart';

@freezed
class PhysicalFitnessEvent with _$PhysicalFitnessEvent {
  const factory PhysicalFitnessEvent.nextQuestion() = NextQuestion;

  const factory PhysicalFitnessEvent.previousQuestion() = PreviousQuestion;
}
