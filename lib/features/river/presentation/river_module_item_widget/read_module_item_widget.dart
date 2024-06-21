import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_circle_color_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_icon_color_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_rotation_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/module_circle_icon_widget.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_item_widget.dart';

class ReadModuleItemWidget extends StatelessWidget {
  final Color iconColor;
  final Color bgColor;
  final double circleRadius;
  final double sizeIcon;
  final IconData icon;
  final bool isAnimated;
  final Color? oldBgColor;
  final double elevation;
  final Function()? onTap;

  const ReadModuleItemWidget({
    super.key,
    required this.iconColor,
    required this.bgColor,
    required this.icon,
    this.isAnimated = false,
    this.circleRadius = 25,
    this.sizeIcon = 36,
    this.elevation = 4,
    this.onTap,
    this.oldBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = isAnimated && oldBgColor != null
        ? AnimatedIconColorWrapper(
            icon: icon,
            newIconColor: iconColor,
            oldIconColor: oldBgColor ?? AppColors.transparent,
            sizeIcon: sizeIcon)
        : Icon(
            icon,
            color: iconColor,
            size: sizeIcon,
          );
    final circleWidget = isAnimated && oldBgColor != null
        ? AnimatedCircleColorWrapper(
            newBgColor: bgColor,
            oldBgColor: oldBgColor ?? AppColors.transparent,
            icon: iconWidget,
          )
        : ModuleCircleIconWidget(
            bgColor: bgColor,
            iconWidget: iconWidget,
          );
    final child = RiverModuleItemWidget(
      elevation: elevation,
      onTap: onTap,
      circleRadius: circleRadius,
      child: circleWidget,
    );
    if (isAnimated) {
      return AnimatedRotationWrapper(child: child);
    } else {
      return child;
    }
  }
}
