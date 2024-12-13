import 'package:flutter/material.dart';

class OptionalRefreshIndicator extends StatelessWidget {
  const OptionalRefreshIndicator({
    super.key,
    required this.child,
    this.onRefresh,
  });

  final RefreshCallback? onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (onRefresh == null) {
      return child;
    }

    return RefreshIndicator(
      onRefresh: onRefresh!,
      child: child,
    );
  }
}
