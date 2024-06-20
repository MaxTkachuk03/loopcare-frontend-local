import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_completed_badge.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_rotation_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_scale_wrapper.dart';
import 'package:loopcare_frontend/features/river/presentation/animation/animated_transition_wrapper.dart';

const radius = 25.0;

class OldRiverModuleItemWidget extends StatefulWidget {
  final RiverModuleItem item;
  final Color _iconColor;
  final Color _bgColor;
  final double circleRadius;
  final double sizeBadge;
  final double sizeIcon;
  final Offset offset;

  final Function()? onTap;

  OldRiverModuleItemWidget.activity({
    super.key,
    required this.item,
    this.circleRadius = 25,
    this.sizeBadge = 15,
    this.sizeIcon = 50,
    required this.offset,
    this.onTap,
  })  : _iconColor = item.iconColor,
        _bgColor = item.bgColor;

  OldRiverModuleItemWidget.reflection({
    super.key,
    required this.item,
    required this.offset,
    this.onTap,
    this.circleRadius = 25,
    this.sizeBadge = 15,
    this.sizeIcon = 50,
  })  : _iconColor = item.iconColor,
        _bgColor = item.bgColor;

  OldRiverModuleItemWidget.practice({
    super.key,
    required this.item,
    required this.offset,
    this.onTap,
    this.circleRadius = 25,
    this.sizeBadge = 15,
    this.sizeIcon = 50,
  })  : _iconColor = item.iconColor,
        _bgColor = item.bgColor;

  @override
  State<OldRiverModuleItemWidget> createState() => _OldRiverModuleItemWidgetState();
}

class _OldRiverModuleItemWidgetState extends State<OldRiverModuleItemWidget>
    with SingleTickerProviderStateMixin {
  bool isMoveToReadState = false;
  bool isMoveToCompletedState = false;
  bool isMoveToUnlockState = false;
  RiverModuleItem? oldModuleItem;

  @override
  void didUpdateWidget(covariant OldRiverModuleItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    isMoveToReadState = false;
    isMoveToCompletedState = false;
    isMoveToUnlockState = false;
    oldModuleItem = oldWidget.item;
    if (oldWidget.item.isLocked && widget.item.isUnLocked) {
      isMoveToUnlockState = true;
    } else if (oldWidget.item.isUnLocked && widget.item.isCompleted) {
      isMoveToCompletedState = true;
    } else if (oldWidget.item.isUnLocked && widget.item.isRead) {
      isMoveToReadState = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(
      widget.item.icon,
      color: widget._iconColor,
      size: widget.sizeIcon,
    );
    final circleWidget = Container(
      decoration: BoxDecoration(
        color: widget.item.bgColor,
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
      child: iconWidget,
    );

    final moduleIconWidget = _InnerModuleItemWidget(
      elevation: widget.item.iconElevation,
      onTap: widget.onTap,
      circleRadius: widget.circleRadius,
      child: circleWidget,
    );
    Widget child = const SizedBox.shrink();
    switch (widget.item.itemState) {
      case RiverModuleItemState.unlocked:
        child = isMoveToUnlockState
            ? AnimatedScaleWrapper(child: moduleIconWidget)
            : AnimatedScaleWrapper(child: moduleIconWidget);
      case RiverModuleItemState.locked:
        child = moduleIconWidget;
      case RiverModuleItemState.read:
        child =
            isMoveToReadState ? AnimatedRotationWrapper(child: moduleIconWidget) : moduleIconWidget;
      case RiverModuleItemState.completed:
        final animatedIcon = _InnerModuleItemWidget(
          elevation: widget.item.iconElevation,
          onTap: widget.onTap,
          circleRadius: widget.circleRadius,
          child: circleWidget,
        );
        child = isMoveToCompletedState
            ? Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedTransitionWrapper(
                    offset: widget.offset,
                    child: animatedIcon,
                  ),
                  moduleIconWidget,
                  Positioned(
                    right: -5,
                    top: -10,
                    child: AnimatedCompletedBadge(sizeBadge: widget.sizeBadge),
                  ),
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
