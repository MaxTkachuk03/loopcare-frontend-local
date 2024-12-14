import 'package:flutter/material.dart';

class ScrollableContainer extends StatelessWidget {
  final Widget child;
  final ScrollPhysics? physics;

  const ScrollableContainer({
    super.key,
    required this.child,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: physics,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        );
      },
    );
  }
}
