import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_button.dart';

const _scaleDuration = Duration(seconds: 2);
const _colorDuration = Duration(seconds: 2);
const _rotationDuration = Duration(seconds: 2);
const _badgeDuration = Duration(seconds: 1);
const _opacityDuration = Duration(seconds: 4);

class RiverAnimationWidget extends StatefulWidget {
  final RiverModuleItem item;
  final Offset offset;
  final double radius;
  final Function()? onTap;

  const RiverAnimationWidget({
    super.key,
    required this.item,
    this.offset = Offset.zero,
    this.radius = 25,
    this.onTap,
  });

  @override
  State<RiverAnimationWidget> createState() => _RiverAnimationWidgetState();
}

class _RiverAnimationWidgetState extends State<RiverAnimationWidget> with TickerProviderStateMixin {
  late AnimationController _idleController;
  late AnimationController _colorController;
  late AnimationController _rotationController;
  late AnimationController _unlockController;
  late AnimationController _badgeController;

  late Animation<Color?> _colorIconAnimation;
  late Animation<Color?> _colorBgAnimation;

  late Animation<double> _idleAnimation;
  late Animation<double> _rotateAnimation;

  late Animation<Offset> _unlockAnimation;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(duration: _scaleDuration, vsync: this);
    _colorController = AnimationController(duration: _colorDuration, vsync: this);
    _rotationController = AnimationController(duration: _rotationDuration, vsync: this);
    _badgeController = AnimationController(duration: _badgeDuration, vsync: this);

    _colorIconAnimation = ColorTween(
      begin: widget.item.iconColor,
      end: widget.item.iconColor,
    ).animate(_colorController);
    _colorBgAnimation = ColorTween(
      begin: widget.item.bgColor,
      end: widget.item.bgColor,
    ).animate(_colorController);

    _unlockAnimation = Tween<Offset>(
      begin: widget.offset,
      //offset navigation bar item
      end: Offset(widget.offset.dx, widget.offset.dy + 100),
    ).animate(_unlockController);

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_rotationController);
    _idleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_idleController);

    _colorController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _startIdling();
      }
    });
    _rotationController.addStatusListener((state) {
      if (state == AnimationStatus.completed && widget.item.featurePlacement != null) {
        _unlockController.forward();
      }
    });
    _unlockController.addStatusListener((state) {
      if (state == AnimationStatus.completed && widget.item.isCompleted) {
        _badgeController.forward();
      }
    });

    //Todo transition end-offset into profile-offset or practice-offset (1/4 screen size)

    _startIdling();
  }

  void _startIdling() {
    if (widget.item.isUnLocked) {
      Future.delayed(const Duration(seconds: 1), _idleController.forward);
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
  void didUpdateWidget(covariant RiverAnimationWidget oldWidget) {
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
      children: [
        if (widget.item.featurePlacement != null)
          SlideTransition(
            position: _unlockAnimation,
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 1.0, end: 0.0),
                curve: Curves.easeInOut,
                duration: _opacityDuration,
                builder: (BuildContext context, double opacity, Widget? child) {
                  return Opacity(
                    opacity: opacity,
                    child: RiverModuleButton(
                      icon: widget.item.icon,
                      radius: widget.radius,
                      bgColor: widget.item.bgColor,
                      iconColor: widget.item.iconColor,
                    ),
                  );
                }),
          ),
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
                    bgColor: _colorBgAnimation.value,
                    iconColor: _colorIconAnimation.value,
                    onPressed: widget.onTap,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
