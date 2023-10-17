import 'package:flutter/material.dart';

class ScrollableContainer extends StatelessWidget {
  final Widget child;
  final ScrollPhysics? physics;

  const ScrollableContainer({
    Key? key,
    required this.child,
    this.physics,
  }) : super(key: key);

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
