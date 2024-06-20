import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/module_item/module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_scale_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_state_wrapper.dart';

const radius = 25.0;

class RiverModuleItem extends StatefulWidget {
  final ModuleItem item;
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
  bool isMoveToReadState = false;
  bool isMoveToCompletedState = false;
  bool isMoveToUnlockState = false;

  @override
  void didUpdateWidget(covariant RiverModuleItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.isLock && widget.item.isUnlock) {
      isMoveToUnlockState = true;
    } else if (oldWidget.item.isRead && widget.item.isCompleted) {
      isMoveToCompletedState = true;
    } else if (oldWidget.item.isUnlock && widget.item.isRead) {
      isMoveToReadState = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconLockWidget = widget.item.isReflection
        ? AppIcons.iReflectionDisable
        : Icon(
      widget.item.icon,
      color: AppColors.blueLightest,
      size: widget.sizeIcon,
    );

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
        boxShadow: [
          BoxShadow(
            color: AppColors.greyLight.withOpacity(0.1),
            spreadRadius: 1.5,
            blurRadius: 1,
          ),
        ],
      ),
      width: 2 * widget.circleRadius,
      height: 2 * widget.circleRadius,
      child:  iconWidget,
    );

    final moduleIconWidget = _InnerModuleItemWidget(
      elevation: widget.item.iconElevation,
      onTap: widget.onTap,
      circleRadius: widget.circleRadius,
      child:  circleWidget,
    );
    Widget child = const SizedBox.shrink();
    switch (widget.item.state) {
      case RiverModuleItemState.unlocked:
        child = isMoveToUnlockState?
    AnimatedScaleWrapper(child: moduleIconWidget)
        : AnimatedScaleWrapper(child: moduleIconWidget);
      case RiverModuleItemState.locked:
        child = moduleIconWidget;
      case RiverModuleItemState.read:
        child = isMoveToReadState ? AnimatedRotationWrapper(child: moduleIconWidget) : moduleIconWidget;
      case RiverModuleItemState.completed:
        child = isMoveToCompletedState
            ? Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedTransitionWrapper(
                    offset: widget.item.offset,
                    child: _InnerModuleItemWidget(
                      elevation: widget.item.iconElevation,
                      onTap: widget.onTap,
                      circleRadius: widget.circleRadius,
                      child: circleWidget,
                    ),
                  ),
                  moduleIconWidget,
                  Positioned(
                      right: -5,
                      top: -10,
                      child: _AnimatedCompletedBadge(sizeBadge: widget.sizeBadge)),
                ],
              )
            : badge.Badge(
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
                child: moduleIconWidget,
              );
    }

    return child;
  }

  Widget get reflectionIcon {
    switch (widget.item.state) {
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

class _AnimatedCompletedBadge extends StatelessWidget {
  final double sizeBadge;

  const _AnimatedCompletedBadge({super.key, required this.sizeBadge});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.ease,
      duration: const Duration(seconds: 4),
      builder: (BuildContext context, double opacity, Widget? child) {
        return Opacity(
          opacity: opacity,
          child: badge.Badge(
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
          ),
        );
      },
    );
  }
}

class _InnerModuleItemWidget extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double circleRadius;
  final Function()? onTap;

  const _InnerModuleItemWidget({
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
