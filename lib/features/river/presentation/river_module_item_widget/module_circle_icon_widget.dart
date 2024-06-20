import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyLight.withOpacity(0.1),
            spreadRadius: 1.5,
            blurRadius: 1,
          ),
        ],
      ),
      width: 2 * circleRadius,
      height: 2 * circleRadius,
      child: iconWidget,
    );
  }
}
