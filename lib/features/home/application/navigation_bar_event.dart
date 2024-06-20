part of 'navigation_bar_bloc.dart';

@freezed
class NavigationBarEvent with _$NavigationBarEvent {
  const factory NavigationBarEvent.init() = InitNavigationBar;

  const factory NavigationBarEvent.setBeginningUncompleted() = SetBeginningUncompleted;

  const factory NavigationBarEvent.unlockPractise() = UnlockPractise;

  const factory NavigationBarEvent.unlockProfile() = UnlockProfile;

  const factory NavigationBarEvent.completeBeginning() = CompleteBeginning;

  const factory NavigationBarEvent.addPractiseNotification() = AddPractiseNotification;

  const factory NavigationBarEvent.removePractiseNotification() = RemovePractiseNotification;

  const factory NavigationBarEvent.addProfileNotification() = AddProfileNotification;

  const factory NavigationBarEvent.removeProfileNotification() = RemoveProfileNotification;
}
