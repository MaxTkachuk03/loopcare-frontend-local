part of 'self_help_bloc.dart';

@freezed
class SelfHelpEvent with _$SelfHelpEvent {
  const factory SelfHelpEvent.setUserPreferGender(PreferGender preferGender) =
      SetUserPreferGender;

  const factory SelfHelpEvent.getUserPreferGender() = GetUserPreferGender;

  const factory SelfHelpEvent.saveUserPreferGender() = SaveUserPreferGender;

  const factory SelfHelpEvent.fetchPreferGendersTypes() =
      FetchPreferGendersTypes;
}
