import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

class TabsState extends InheritedWidget {
  final DashboardNavbarItems selectedNavigationItem;
  final Function(int index) onNavigationPressed;

  const TabsState({
    Key? key,
    required this.selectedNavigationItem,
    required this.onNavigationPressed,
    required Widget child,
  }) : super(key: key, child: child);

  static TabsState of(BuildContext context) {
    final TabsState? result =
        context.dependOnInheritedWidgetOfExactType<TabsState>();
    assert(result != null, 'No TabsState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TabsState oldWidget) {
    return selectedNavigationItem != oldWidget.selectedNavigationItem;
  }
}
