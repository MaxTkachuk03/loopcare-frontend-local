part of 'physical_fitness_bloc.dart';

@freezed
class PhysicalFitnessEvent with _$PhysicalFitnessEvent {
  const factory PhysicalFitnessEvent.nextQuestion() = NextQuestion;

  const factory PhysicalFitnessEvent.previousQuestion() = PreviousQuestion;

  const factory PhysicalFitnessEvent.heightChanged(String height) =
      HeightChanged;

  const factory PhysicalFitnessEvent.weightChanged(String weight) =
      WeightChanged;

  const factory PhysicalFitnessEvent.birthdayChanged(DateTime birthday) =
      BirthdayChanged;

  const factory PhysicalFitnessEvent.sexChanged(SexType sexType) = SexChanged;

  const factory PhysicalFitnessEvent.biologicalGenderChanged(
    BiologicalGenderType biologicalGender,
  ) = BiologicalGenderChanged;
}
