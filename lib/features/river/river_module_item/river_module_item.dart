import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/animation/animated_scale_wrapper.dart';
import 'package:loopcare_frontend/features/river/animation/animated_state_wrapper.dart';
import 'package:loopcare_frontend/features/river/river_module_item/module_item_state.dart';
import 'package:loopcare_frontend/features/river/river_module_item/river_module_item_utils.dart';

const circleRadius = 25.0;
const sizeBadge = 15.0;
const sizeIcon = 36.0;

class RiverModuleItem extends StatefulWidget {
  final ModuleItemMode mode;
  final Function()? onTap;

  const RiverModuleItem({
    super.key,
    required this.mode,
    this.onTap,
  });

  @override
  State<RiverModuleItem> createState() => _RiverModuleItemState();
}

class _RiverModuleItemState extends State<RiverModuleItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ColorTween _bgTween;
  late ColorTween _fgTween;
  Animation<Color?>? _bgAnimation;
  Animation<Color?>? _fgAnimation;

  Color get bgColor => widget.mode.bgColor;

  IconData get icon => widget.mode.contentType.getIcon();

  Color get iconColor => widget.mode.iconColor;

  double get iconElevation => widget.mode.state.getIconElevation();
  final duration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );
    _bgTween = ColorTween(begin: bgColor, end: widget.mode.contentColor);

    _fgTween = ColorTween(begin: widget.mode.contentColor, end: AppColors.white);
  }

  void _animation() {
    _bgAnimation = _bgTween.animate(_controller);
    _fgAnimation = _fgTween.animate(_controller);
    setState(() {
      _bgAnimation?.value;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconWidget = widget.mode.contentType.isActivity
        ? activityIcon
        : Icon(
            icon,
            color: iconColor,
            size: sizeIcon,
          );
    final circleWidget = Container(
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      width: 2 * circleRadius,
      height: 2 * circleRadius,
      child: iconWidget,
    );

    final wrapWidget = _InnerWidget(
      elevation: iconElevation,
      onTap: widget.onTap,
      child: circleWidget,
    );

    final child = widget.mode.onMap(
      disable: () => wrapWidget,
      unlock: () => AnimatedScaleWrapper(child: wrapWidget),
      read: () => AnimatedStateWrapper(
        animate: _animation,
        child: AnimatedScaleWrapper(
          child: Material(
            elevation: iconElevation,
            borderRadius: const BorderRadius.all(Radius.circular(circleRadius)),
            child: _InnerWidget(
              elevation: iconElevation,
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.mode.state.name == RiverModuleItemState.read.name &&
                          _bgAnimation?.value != null
                      ? _bgAnimation!.value!
                      : RiverModuleItemState.unlock.getBackgroundColor(widget.mode.contentColor),
                  shape: BoxShape.circle,
                ),
                width: 2 * circleRadius,
                height: 2 * circleRadius,
                child: widget.mode.contentType.isActivity
                    ? activityIcon
                    : Icon(
                        icon,
                        color: widget.mode.state.name == RiverModuleItemState.read.name &&
                                _fgAnimation?.value != null
                            ? _fgAnimation!.value!
                            : RiverModuleItemState.unlock.getIconColor(widget.mode.contentColor),
                        size: sizeIcon,
                      ),
              ),
            ),
          ),
        ),
      ),
      completed: () => wrapWidget,
    );
    if (widget.mode.state.name == RiverModuleItemState.completed.name) {
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

  Widget get activityIcon => widget.mode.onMap(
        disable: () => AppIcons.iReflectionDisable,
        unlock: () => AppIcons.iReflectionUnlock,
        read: () => AppIcons.iReflectionCompleted,
        completed: () => AppIcons.iReflectionCompleted,
      );
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
