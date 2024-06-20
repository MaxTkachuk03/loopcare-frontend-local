import 'package:flutter/material.dart';

const radius = 25.0;

class RiverModuleItemWidget extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double circleRadius;
  final Function()? onTap;

  const RiverModuleItemWidget({
    super.key,
    required this.child,
    required this.elevation,
    this.onTap,
    this.circleRadius = radius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.all(Radius.circular(circleRadius)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(circleRadius)),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
