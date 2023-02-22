part of 'self_help_bloc.dart';

@freezed
class SelfHelpEvent with _$SelfHelpEvent {
  const factory SelfHelpEvent.nextQuestion() = NextQuestion;

  const factory SelfHelpEvent.previousQuestion() = PreviousQuestion;

  const factory SelfHelpEvent.resetData() = ResetData;

  const factory SelfHelpEvent.setUserPreferGender(
    PreferGenderType preferGender,
  ) = SetUserPreferGender;

  const factory DiabetesEvent.getUserPreferGender() = GetUserPreferGender;

   const factory DiabetesEvent.saveUserPreferGender() = SaveUserPreferGender;


}
