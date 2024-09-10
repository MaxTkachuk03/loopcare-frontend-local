part of 'general_onboarding_bloc.dart';

@freezed
class GeneralOnboardingEvent with _$GeneralOnboardingEvent {
  const factory GeneralOnboardingEvent.start() = Started;

  const factory GeneralOnboardingEvent.nextStep({@Default(false) bool excluded}) = NextStep;

  const factory GeneralOnboardingEvent.previousStep() = PreviousStep;

  const factory GeneralOnboardingEvent.resetData() = ResetData;

  const factory GeneralOnboardingEvent.startTimer({DateTime? startTime}) = StartTimer;

  const factory GeneralOnboardingEvent.stopTimer({@Default(false) bool isTimeUp}) = StopTimer;

  const factory GeneralOnboardingEvent.resumeTimer() = ResumeTimer;

  const factory GeneralOnboardingEvent.startMentalTestFromBeginning() =
      StartMentalTestFromBeginning;

  const factory GeneralOnboardingEvent.updatePregnancyQuestion({required bool enable}) =
      UpdatePregnancyQuestion;

  const factory GeneralOnboardingEvent.excludeMentalQuestionsByGender({required SexType sex}) =
      ExcludeMentalQuestionsByGender;
}
