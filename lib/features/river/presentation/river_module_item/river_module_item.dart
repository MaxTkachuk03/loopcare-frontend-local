import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/module_item/module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_scale_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_state_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item/river_module_item_utils.dart';

const circleRadius = 25.0;
const sizeBadge = 15.0;
const sizeIcon = 36.0;

class RiverModuleItem extends StatefulWidget {
  final ModuleItem item;

  final Function()? onTap;

  const RiverModuleItem({
    super.key,
    required this.item,
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
            size: sizeIcon,
          );
    final circleWidget = Container(
      decoration: BoxDecoration(
        color: widget.item.bgColor,
        shape: BoxShape.circle,
      ),
      width: 2 * circleRadius,
      height: 2 * circleRadius,
      child: iconWidget,
    );

    final wrapWidget = _InnerWidget(
      elevation: widget.item.iconElevation,
      onTap: widget.onTap,
      child: circleWidget,
    );
    Widget? child;
    switch (widget.item.state) {
      case RiverModuleItemState.unlock:
        child = AnimatedScaleWrapper(child: wrapWidget);
      case RiverModuleItemState.disable:
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
        badgeContent: const Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Icon(
            Icons.check,
            color: AppColors.white,
            size: sizeBadge,
          ),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }

  Widget get reflectionIcon {
    switch (widget.item.state) {
      case RiverModuleItemState.unlock:
        return AppIcons.iReflectionUnlock;
      case RiverModuleItemState.disable:
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
  final Function()? onTap;

  const _InnerWidget({
    super.key,
    required this.child,
    required this.elevation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: const BorderRadius.all(Radius.circular(circleRadius)),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
