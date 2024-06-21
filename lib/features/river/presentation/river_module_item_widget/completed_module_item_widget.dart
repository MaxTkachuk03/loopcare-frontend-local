import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_circle_color_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_completed_badge.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_icon_color_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_transition_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/module_circle_icon_widget.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_item_widget.dart';

class CompletedModuleItemWidget extends StatelessWidget {
  final Color iconColor;
  final Color bgColor;
  final double circleRadius;
  final double sizeIcon;
  final IconData icon;
  final bool isAnimated;
  final Color? oldBgColor;
  final double elevation;
  final double sizeBadge;
  final Offset offset;
  final Function()? onTap;

  const CompletedModuleItemWidget({
    super.key,
    required this.iconColor,
    required this.bgColor,
    required this.icon,
    required this.offset,
    this.isAnimated = false,
    this.circleRadius = 25,
    this.sizeIcon = 36,
    this.elevation = 4,
    this.sizeBadge = 15,
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
    final animatedWidget = circleWidget;
    if (isAnimated) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedTransitionWrapper(
            offset: offset,
            child: animatedWidget,
          ),
          child,
          Positioned(
            right: -5,
            top: -10,
            child: AnimatedCompletedBadge(sizeBadge: sizeBadge),
          ),
        ],
      );
    } else {
      return badge.Badge(
        badgeStyle: const badge.BadgeStyle(
          padding: EdgeInsets.all(5),
          badgeColor: AppColors.blueRegular,
          elevation: 0,
        ),
        badgeAnimation: const badge.BadgeAnimation.slide(toAnimate: false),
        position: badge.BadgePosition.topEnd(top: -8, end: -4),
        badgeContent: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Icon(
            Icons.check,
            color: AppColors.white,
            size: sizeBadge,
          ),
        ),
        child: child,
      );
    }
  }
}
