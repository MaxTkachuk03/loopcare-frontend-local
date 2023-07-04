part of 'home_bottom_navigation_bloc.dart';

@freezed
class HomeBottomNavigationEvent with _$HomeBottomNavigationEvent {
  const factory HomeBottomNavigationEvent.tabChanged(DashboardNavbarItems tab) = TabChanged;
}
