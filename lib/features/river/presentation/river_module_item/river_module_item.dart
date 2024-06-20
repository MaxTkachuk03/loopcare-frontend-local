import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart' as model;
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_scale_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_state_wrapper.dart';

const radius = 25.0;

class RiverModuleItem extends StatefulWidget {
  final model.RiverModuleItem item;
  final double circleRadius;
  final double sizeBadge;
  final double sizeIcon;

  final Function()? onTap;

  const RiverModuleItem({
    super.key,
    required this.item,
    this.circleRadius = radius,
    this.sizeBadge = 15,
    this.sizeIcon = 36,
    this.onTap,
  });

  @override
  State<RiverModuleItem> createState() => _RiverModuleItemState();
}

class _RiverModuleItemState extends State<RiverModuleItem> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final iconWidget = widget.item.isReflection
        ? reflectionIcon
        : Icon(
            widget.item.icon,
            color: widget.item.iconColor,
            size: widget.sizeIcon,
          );
    final circleWidget = Container(
      decoration: BoxDecoration(
        color: widget.item.isReflection ? AppColors.transparent : widget.item.bgColor,
        shape: BoxShape.circle,
      ),
      width: 2 * widget.circleRadius,
      height: 2 * widget.circleRadius,
      child: iconWidget,
    );

    final wrapWidget = _InnerWidget(
      elevation: widget.item.iconElevation,
      onTap: widget.onTap,
      circleRadius: widget.circleRadius,
      child: circleWidget,
    );
    Widget? child;
    switch (widget.item.itemState) {
      case RiverModuleItemState.unlocked:
        child = AnimatedScaleWrapper(child: wrapWidget);
      case RiverModuleItemState.locked:
        child = wrapWidget;
      case RiverModuleItemState.read:
        child = AnimatedStateWrapper(child: wrapWidget);
      case RiverModuleItemState.completed:
        child = wrapWidget;
    }
    if (widget.item.isCompleted) {
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
            size: widget.sizeBadge,
          ),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }

  Widget get reflectionIcon {
    switch (widget.item.itemState) {
      case RiverModuleItemState.unlocked:
        return AppIcons.iReflectionUnlock;
      case RiverModuleItemState.locked:
        return AppIcons.iReflectionDisable;
      case RiverModuleItemState.completed:
      case RiverModuleItemState.read:
        return AppIcons.iReflectionCompleted;
    }
  }
}

class _InnerWidget extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double circleRadius;
  final Function()? onTap;

  const _InnerWidget({
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
        onTap: onTap,
        child: child,
      ),
    );
  }
}
