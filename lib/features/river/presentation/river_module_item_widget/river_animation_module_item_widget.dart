import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_button.dart';

const _idleDuration = Duration(seconds: 3);
const _colorDuration = Duration(seconds: 2);
const _rotationDuration = Duration(seconds: 2);
const _unlockDuration = Duration(seconds: 2);
const _badgeDuration = Duration(seconds: 1);
const _opacityDuration = Duration(milliseconds: 360);

class RiverAnimationModuleItemWidget extends StatefulWidget {
  final RiverModuleItem item;
  final Offset offset;
  final double radius;
  final double sizeIcon;
  final double sizeBadge;
  final Function()? onTap;

  const RiverAnimationModuleItemWidget({
    super.key,
    required this.item,
    this.offset = Offset.zero,
    this.radius = 25,
    this.sizeIcon = 36,
    this.sizeBadge = 15,
    this.onTap,
  });

  @override
  State<RiverAnimationModuleItemWidget> createState() => _RiverAnimationModuleItemWidgetState();
}

class _RiverAnimationModuleItemWidgetState extends State<RiverAnimationModuleItemWidget> with TickerProviderStateMixin {
  late AnimationController _idleController;
  late AnimationController _colorController;
  late AnimationController _rotationController;
  late AnimationController _unlockController;
  late AnimationController _badgeController;
  late AnimationController _opacityController;

  late Animation<Color?> _colorIconAnimation;
  late Animation<Color?> _colorBgAnimation;

  Animation<double> get _rotateAnimation => Tween<double>(begin: 0.0, end: 2.0)
      .chain(CurveTween(curve: Curves.ease))
      .animate(_rotationController);

  Animation<Offset> get _unlockAnimation => Tween<Offset>(
        begin: Offset.zero,
        //offset navigation bar item
        end: Offset(widget.offset.dx, widget.offset.dy + 100),
      ).animate(_unlockController);

  Animation<double> get _idleAnimation =>
      Tween<double>(begin: 1.0, end: 1.1).animate(_idleController);

  Animation<double> get _badgeAnimation =>
      Tween<double>(begin: 0.0, end: 1.0).animate(_badgeController);

  Animation<double> get _opacityAnimation =>
      Tween<double>(begin: 0.0, end: 1.0).animate(_opacityController);

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(duration: _idleDuration, vsync: this);
    _colorController = AnimationController(duration: _colorDuration, vsync: this);
    _rotationController = AnimationController(duration: _rotationDuration, vsync: this);
    _badgeController = AnimationController(duration: _badgeDuration, vsync: this);
    _unlockController = AnimationController(duration: _unlockDuration, vsync: this);
    _opacityController = AnimationController(duration: _opacityDuration, vsync: this);

    _colorIconAnimation = ColorTween(
      begin: widget.item.iconColor,
      end: widget.item.iconColor,
    ).animate(_colorController);

    _colorBgAnimation = ColorTween(
      begin: widget.item.bgColor,
      end: widget.item.bgColor,
    ).animate(_colorController);

    _colorListener();
    _rotationListener();
    _unlockListener();
    _idleController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _idleController.reverse();
        _idleController.forward();
      }
    });

    //Todo transition end-offset into profile-offset or practice-offset (1/4 screen size)

    _startIdling();
  }

  void _colorListener() {
    _colorController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _startIdling();
      }
    });
  }

  void _rotationListener() {
    _rotationController.addStatusListener((state) {
      if (state == AnimationStatus.completed && widget.item.featurePlacement != null) {
        _opacityController.forward();
        _unlockController.forward();
      }
    });
  }

  void _unlockListener() {
    _unlockController.addStatusListener((state) {
      if (state == AnimationStatus.completed && widget.item.isCompleted) {
        _badgeController.forward();
      }
    });
  }

  void _startIdling() {
    if (widget.item.isUnLocked) {
      Future.delayed(const Duration(seconds: 1), ()=>_idleController.repeat(reverse: true));
    }
  }

  @override
  void dispose() {
    _idleController.dispose();
    _colorController.dispose();
    _rotationController.dispose();
    _unlockController.dispose();
    _badgeController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RiverAnimationModuleItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _colorIconAnimation = ColorTween(
      begin: oldWidget.item.iconColor,
      end: widget.item.iconColor,
    ).animate(_colorController);
    _colorBgAnimation = ColorTween(
      begin: oldWidget.item.bgColor,
      end: widget.item.bgColor,
    ).animate(_colorController);

    if (oldWidget.item.isLocked && widget.item.isUnLocked) {
      _colorController.forward();
    } else if (oldWidget.item.isUnLocked && (widget.item.isRead || widget.item.isCompleted)) {
      _idleController.reset();
      _rotationController.forward();
      _colorController.forward();
    } else if (oldWidget.item.isRead && widget.item.isCompleted) {
      _badgeController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        if (widget.item.featurePlacement != null && widget.item.isCompleted)
          AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, _) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: SlideTransition(
                    position: _unlockAnimation,
                    child: RiverModuleButton(
                      icon: widget.item.icon,
                      radius: widget.radius,
                      bgColor: widget.item.bgColor,
                      iconColor: widget.item.iconColor,
                    ),
                  ),
                );
              }),
        AnimatedBuilder(
          animation: _colorController,
          builder: (context, _) => AnimatedBuilder(
              animation: _idleController,
              builder: (context, _) {
                return AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(math.pi * _rotateAnimation.value),
                      child: child,
                    );
                  },
                  child: RiverModuleButton(
                    icon: widget.item.icon,
                    radius: widget.radius * _idleAnimation.value,
                    sizeIcon: widget.sizeIcon * _idleAnimation.value,
                    bgColor: _colorBgAnimation.value,
                    iconColor: _colorIconAnimation.value,
                    onPressed: widget.onTap,
                  ),
                );
              }),
        ),
        Positioned(
          right: -5,
          top: -10,
          child: AnimatedBuilder(
              animation: _badgeController,
              builder: (context, _) {
                return Opacity(
                  opacity: _badgeAnimation.value,
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
                        size: widget.sizeBadge,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
