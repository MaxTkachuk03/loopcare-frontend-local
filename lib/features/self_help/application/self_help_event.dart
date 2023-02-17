part of 'physical_fitness_bloc.dart';

@freezed
class SelfHelpEvent with _$SelfHelpEvent {
  const factory SelfHelpEvent.nextQuestion() = NextQuestion;

  const factory SelfHelpEvent.previousQuestion() = PreviousQuestion;

  const factory SelfHelpEvent.resetData() = ResetData;

  const factory SelfHelpEvent.preferGenderChanged(
    PreferGenderType preferGender,
  ) = PreferGenderTypeChanged;
}
