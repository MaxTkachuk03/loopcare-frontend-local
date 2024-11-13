import 'package:flutter/material.dart';

class StepNavigationState extends InheritedWidget {
  const StepNavigationState({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
    required super.child,
  });

  final VoidCallback onNextPage;
  final Future<bool> Function() onPreviousPage;

  static StepNavigationState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StepNavigationState>();
  }

  static StepNavigationState of(BuildContext context) {
    final StepNavigationState? result = maybeOf(context);

    assert(result != null, 'No navigation found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(StepNavigationState oldWidget) => true;
}
