part of 'self_help_bloc.dart';

@freezed
class SelfHelpEvent with _$SelfHelpEvent {
  const factory SelfHelpEvent.setAccountPreferGender(
      PreferGender preferGender) = SetAccountPreferGender;

  const factory SelfHelpEvent.getAccountPreferGender() = GetAccountPreferGender;

  const factory SelfHelpEvent.saveAccountPreferGender() =
      SaveAccountPreferGender;

  const factory SelfHelpEvent.fetchPreferGendersTypes() =
      FetchPreferGendersTypes;
}
