import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModuleCircleIconWidget extends StatelessWidget {
  final Color bgColor;
  final Widget iconWidget;
  final double circleRadius;

  const ModuleCircleIconWidget({
    super.key,
    required this.bgColor,
    required this.iconWidget,
    this.circleRadius = 25,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(backgroundColor: bgColor, radius: circleRadius, child: iconWidget);
  }
}
