part of 'physical_fitness_bloc.dart';

@freezed
class PhysicalFitnessEvent with _$PhysicalFitnessEvent {
  const factory PhysicalFitnessEvent.nextQuestion() = NextQuestion;

  const factory PhysicalFitnessEvent.previousQuestion() = PreviousQuestion;

  const factory PhysicalFitnessEvent.heightChanged({
    required String height,
    required MeasurementSystemType measurementSystemType,
  }) = HeightChanged;

  const factory PhysicalFitnessEvent.weightChanged({
    required String weight,
    required MeasurementSystemType measurementSystemType,
  }) = WeightChanged;

  const factory PhysicalFitnessEvent.birthdayChanged(DateTime birthday) =
      BirthdayChanged;

  const factory PhysicalFitnessEvent.sexChanged(SexType sexType) = SexChanged;

  const factory PhysicalFitnessEvent.biologicalGenderChanged(
    BiologicalGenderType biologicalGender,
  ) = BiologicalGenderChanged;
}
