import 'dart:math' as math;

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/blue_river_module_item_state.dart';
import 'package:loopcare_frontend/features/river/infrastructure/feature_placement.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_button.dart';
import 'package:visibility_detector/visibility_detector.dart';

const _idleDuration = Duration(milliseconds: 2000);
const _colorDuration = Duration(milliseconds: 1000);
const _rotationDuration = Duration(milliseconds: 1000);
const _unlockDuration = Duration(milliseconds: 1000);
const _badgeDuration = Duration(milliseconds: 300);

class RiverAnimationModuleItemWidget extends StatefulWidget {
  final RiverModuleItem item;
  final double radius;
  final Function()? onTap;
  final Function()? onStatusChanged;
  final Function(FeaturePlacement placement)? onTransitionComplete;
  final bool isBeginning;

  const RiverAnimationModuleItemWidget({
    super.key,
    required this.item,
    this.radius = 25,
    this.isBeginning = false,
    this.onTap,
    this.onStatusChanged,
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
  bool _isOnViewport = false;

  _ItemAnimation? _itemAnimation;

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
    _setUpItemColorAnimation(oldWidget.item, widget.item);

    if (oldWidget.item.isLocked && widget.item.isUnLocked) {
      _itemAnimation = _ItemAnimation.unlock;
    } else if (oldWidget.item.isUnLocked && (widget.item.isRead || widget.item.isCompleted)) {
      _itemAnimation = _ItemAnimation.readAndComplete;
    } else if (oldWidget.item.isRead && widget.item.isCompleted) {
      _itemAnimation = _ItemAnimation.complete;
    }

    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animated_module_item_${widget.item.id}'),
      onVisibilityChanged: onViewPortChanged,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (_enableFootprint)
            SlideTransition(
              position: _unlockAnimation,
              child: RiverModuleButton(
                icon: widget.item.icon,
                radius: widget.radius,
                bgColor: _getBackgroundColor(widget.item),
                iconColor: _getIconColor(widget.item),
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
                    ..scale(_idleAnimation.value, _idleAnimation.value),
                  child: child,
                ),
                child: RiverModuleButton(
                  key: _buttonKey,
                  icon: widget.item.icon,
                  radius: widget.radius,
                  bgColor: _colorBgAnimation.value,
                  iconColor: _colorIconAnimation.value,
                  onPressed: widget.item.isLocked ? null : widget.onTap,
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
      ),
    );
  }

  void _setUpAnimations() {
    _setUpItemColorAnimation(widget.item, widget.item);

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

  void _clearItemAnimation() => _itemAnimation = null;

  Color _getIconColor(RiverModuleItem item) {
    if (widget.isBeginning) {
      return BlueRiverModuleItemState.iconColor(item.itemState);
    } else {
      return item.iconColor;
    }
  }

  Color _getBackgroundColor(RiverModuleItem item) {
    if (widget.isBeginning) {
      return BlueRiverModuleItemState.backgroundColor(item.itemState);
    } else {
      return item.bgColor;
    }
  }

  void _setUpItemColorAnimation(RiverModuleItem begin, RiverModuleItem end) {
    _colorIconAnimation = ColorTween(
      begin: _getIconColor(begin),
      end: _getIconColor(end),
    ).animate(_colorController);

    _colorBgAnimation = ColorTween(
      begin: _getBackgroundColor(begin),
      end: _getBackgroundColor(end),
    ).animate(_colorController);
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

      if (widget.item.isUnLocked) {
        _clearItemAnimation();
      }
    }
  }

  void _rotationListener(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      if (widget.item.featurePlacement != null) {
        setState(() => _enableFootprint = true);
        _unlockController.forward();
      } else if (widget.item.isCompleted) {
        _runComplete();
      } else {
        _clearItemAnimation();
      }
    }
  }

  void _unlockListener(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      widget.onTransitionComplete?.call(widget.item.featurePlacement!);
      if (widget.item.isCompleted) {
        _runComplete();
      } else {
        _clearItemAnimation();
      }
    }
  }

  void _badgeListener(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      widget.onStatusChanged?.call();
      _clearItemAnimation();
    }
  }

  void _startAnimation() {
    if (_isOnViewport && _itemAnimation != null) {
      switch (_itemAnimation) {
        case _ItemAnimation.unlock:
          _runUnlock();
        case _ItemAnimation.readAndComplete:
          _runRead();
        case _ItemAnimation.complete:
          _runComplete();
        default:
          return;
      }
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

  void onViewPortChanged(VisibilityInfo info) {
    _isOnViewport = info.visibleFraction > 0;
    _startAnimation();
  }

  void _updateUnlockAnimation() {
    final itemPosition = _definePosition();

    final screenSize = MediaQuery.of(context).size;
    final offsetCoefficient = (widget.item.featurePlacement?.isDashboard ?? false) ? 1 : 3;
    final targetDxOffset = (widget.item.featurePlacement?.isDashboard ?? false) ? widget.radius :  - widget.radius;

    final dy = (screenSize.height - itemPosition.dy - kBottomNavigationBarHeight * 2) / widget.radius;
    final dx = (offsetCoefficient * (screenSize.width / 4) - itemPosition.dx - targetDxOffset) / widget.radius;

    final endOffset = Offset(dx, dy);

    _unlockAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: endOffset,
    ).animate(_unlockController);
  }

  Offset _definePosition() {
    final itemContext = _buttonKey.currentContext;
    if (itemContext == null) {
      throw FlutterError('No context in RiverModuleButton');
    }

    final RenderBox button = itemContext.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;

    return button.localToGlobal(Offset.zero, ancestor: overlay).translate(widget.radius, 0);
  }
}

enum _ItemAnimation {
  unlock,
  readAndComplete,
  complete,
}
