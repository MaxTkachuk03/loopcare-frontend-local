part of 'navigation_bar_bloc.dart';

@freezed
class NavigationBarState with _$NavigationBarState {
  const factory NavigationBarState.initialised(NavigationBarStateData data) =
      NavigationBarStateInitialised;

  const factory NavigationBarState.beginningUncompleted(NavigationBarStateData data) =
      BeginningUncompletedState;

  const factory NavigationBarState.moduleOpened(NavigationBarStateData data) = ModuleOpenedState;

  const factory NavigationBarState.notificationPlaced(NavigationBarStateData data) =
      NotificationPlacedState;
}

@freezed
class NavigationBarStateData with _$NavigationBarStateData {
  const NavigationBarStateData._();

  const factory NavigationBarStateData({
    @Default(true) bool isBeginningCompleted,
    @Default(true) bool isPracticeOpen,
    @Default(true) bool isProfileOpen,
    @Default(false) bool hasPracticeNotification,
    @Default(false) bool hasProfileNotification,
  }) = _NavigationBarStateData;

  factory NavigationBarStateData.fromJson(Map<String, dynamic> json) =>
      _$NavigationBarStateDataFromJson(json);
}
