part of 'home_bottom_navigation_bloc.dart';

@freezed
class HomeBottomNavigationState with _$HomeBottomNavigationState {
  const factory HomeBottomNavigationState({
    required DashboardNavbarItems activeTab,
  }) = _HomeBottomNavigationState;

  factory HomeBottomNavigationState.initial() => const HomeBottomNavigationState(
    activeTab: DashboardNavbarItems.today,
  );
}
