import 'dart:math' as math;

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/feature_placement.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_button.dart';

const _idleDuration = Duration(milliseconds: 2000);
const _colorDuration = Duration(milliseconds: 1000);
const _rotationDuration = Duration(milliseconds: 1000);
const _unlockDuration = Duration(milliseconds: 1500);
const _badgeDuration = Duration(milliseconds: 350);

class RiverAnimationModuleItemWidget extends StatefulWidget {
  final RiverModuleItem item;
  final double radius;
  final Function()? onTap;
  final Function()? onCompleted;
  final Function(FeaturePlacement placement)? onTransitionComplete;

  const RiverAnimationModuleItemWidget({
    super.key,
    required this.item,
    this.radius = 25,
    this.onTap,
    this.onCompleted,
    this.onTransitionComplete,
  });

  @override
  State<RiverAnimationModuleItemWidget> createState() => _RiverAnimationModuleItemWidgetState();
}

class _RiverAnimationModuleItemWidgetState extends State<RiverAnimationModuleItemWidget> with TickerProviderStateMixin {
  final GlobalKey _buttonKey = GlobalKey();

  late AnimationController _idleController;
  late AnimationController _colorController;
  late AnimationController _rotationController;
  late AnimationController _unlockController;
  late AnimationController _badgeController;

  late Animation<Color?> _colorIconAnimation;
  late Animation<Color?> _colorBgAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<Offset> _unlockAnimation;
  late Animation<double> _idleAnimation;
  late Animation<double> _badgeAnimation;

  bool _enableFootprint = false;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(duration: _idleDuration, vsync: this);
    _colorController = AnimationController(duration: _colorDuration, vsync: this);
    _rotationController = AnimationController(duration: _rotationDuration, vsync: this);
    _badgeController = AnimationController(duration: _badgeDuration, vsync: this);
    _unlockController = AnimationController(duration: _unlockDuration, vsync: this);

    if (widget.item.isCompleted) {
      _badgeController.animateTo(1);
    }

    _setUpAnimations();
    _addListeners();
    _startIdling();
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
      _runUnlock();
    } else if (oldWidget.item.isUnLocked && (widget.item.isRead || widget.item.isCompleted)) {
      _runRead();
    } else if (oldWidget.item.isRead && widget.item.isCompleted) {
      _runComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        if (_enableFootprint)
          SlideTransition(
            position: _unlockAnimation,
            child: RiverModuleButton(
              icon: widget.item.icon,
              radius: widget.radius,
              bgColor: widget.item.bgColor,
              iconColor: widget.item.iconColor,
            ),
          ),
        AnimatedBuilder(
          animation: _colorController,
          builder: (context, _) => AnimatedBuilder(
            animation: _idleController,
            builder: (context, _) => AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(math.pi * _rotateAnimation.value)
                  ..scale(_idleAnimation.value, _idleAnimation.value,),
                child: child,
              ),
              child: RiverModuleButton(
                key: _buttonKey,
                icon: widget.item.icon,
                radius: widget.radius,
                bgColor: _colorBgAnimation.value,
                iconColor: _colorIconAnimation.value,
                onPressed: widget.onTap,
              ),
            ),
          ),
        ),
        Positioned(
          right: -5,
          top: -10,
          child: AnimatedBuilder(
            animation: _badgeController,
            builder: (context, child) => Transform.scale(
              scale: _badgeAnimation.value,
              child: child,
            ),
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
                  size: widget.radius * 0.44,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _setUpAnimations() {
    _colorIconAnimation = ColorTween(
      begin: widget.item.iconColor,
      end: widget.item.iconColor,
    ).animate(_colorController);

    _colorBgAnimation = ColorTween(
      begin: widget.item.bgColor,
      end: widget.item.bgColor,
    ).animate(_colorController);

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_rotationController);

    _unlockAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_unlockController);

    _idleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_idleController);
    _badgeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_badgeController);
  }

  void _addListeners() {
    _colorController.addStatusListener(_colorListener);
    _rotationController.addStatusListener(_rotationListener);
    _unlockController.addStatusListener(_unlockListener);
    _badgeController.addStatusListener(_badgeListener);
  }

  void _colorListener(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      _startIdling();
    }
  }

  void _rotationListener(AnimationStatus state) {
    if (state == AnimationStatus.completed && widget.item.featurePlacement != null) {
      setState(() => _enableFootprint = true);
      _unlockController.forward();
    }
  }

  void _unlockListener(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      widget.onTransitionComplete?.call(widget.item.featurePlacement!);
      if (widget.item.isCompleted) {
        _runComplete();
      }
    }
  }

  void _badgeListener(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      widget.onCompleted?.call();
    }
  }

  void _startIdling() {
    if (widget.item.isUnLocked) {
      Future.delayed(const Duration(seconds: 1), () => _idleController.repeat(reverse: true));
    }
  }

  void _runUnlock() {
    _colorController.forward();
  }

  void _runRead() {
    if (widget.item.featurePlacement != null) {
      _updateUnlockAnimation();
    }

    _idleController.reset();
    _rotationController.forward();
    _colorController.forward();
  }

  void _runComplete() {
    _badgeController.forward();
  }

  void _updateUnlockAnimation() {
    final itemPosition = _definePosition();

    final screenSize = MediaQuery.of(context).size;
    final offsetCoefficient = (widget.item.featurePlacement?.isDashboard ?? false) ? 1 : 3;

    final dy = (screenSize.height - itemPosition.dy - kBottomNavigationBarHeight * 2 - widget.radius) / widget.radius;
    final dx = (offsetCoefficient * (screenSize.width / 4) - itemPosition.dx) / widget.radius;

    final endOffset = Offset(dx, dy);

    _unlockAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: endOffset,
    ).animate(_unlockController);
  }

  Offset _definePosition() {
    final itemContext = _buttonKey.currentContext;
    if (itemContext == null) {
      throw FlutterError('no context');
    }

    final RenderBox button = itemContext.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;

    return button.localToGlobal(Offset.zero, ancestor: overlay);
  }
}
