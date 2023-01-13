import 'package:flutter/material.dart';

class PhysicalFitnessNavigationState extends InheritedWidget {
  const PhysicalFitnessNavigationState({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
    required super.child,
  });

  final VoidCallback onNextPage;
  final Future<bool> Function() onPreviousPage;

  static PhysicalFitnessNavigationState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PhysicalFitnessNavigationState>();
  }

  static PhysicalFitnessNavigationState of(BuildContext context) {
    final PhysicalFitnessNavigationState? result = maybeOf(context);
    assert(result != null, 'No PhysicalFitnessNavigation found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PhysicalFitnessNavigationState oldWidget) => true;
}
