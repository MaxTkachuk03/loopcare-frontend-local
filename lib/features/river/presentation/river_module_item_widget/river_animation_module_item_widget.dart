import 'dart:math' as math;

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/custom_navigation_bar/animated_bottom_bar.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/feature_placement.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_button.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_module_item_preview.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

part 'parts/_flying_item.dart';
part 'parts/_river_item_footprint.dart';

const _defaultItemRadius = 25.0;
const _idleDuration = Duration(milliseconds: 2000);
const _idleDelayDuration = Duration(milliseconds: 1000);
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
    this.radius = _defaultItemRadius,
    this.isBeginning = false,
    this.onTap,
    this.onStatusChanged,
    this.onTransitionComplete,
  });

  @override
  State<RiverAnimationModuleItemWidget> createState() => _RiverAnimationModuleItemWidgetState();
}

class _RiverAnimationModuleItemWidgetState extends State<RiverAnimationModuleItemWidget>
    with TickerProviderStateMixin, RiverUtils {
  final GlobalKey _buttonKey = GlobalKey();

  late AnimationController _idleController;
  late AnimationController _colorController;
  late AnimationController _rotationController;
  late AnimationController _badgeController;

  late Animation<Color?> _colorIconAnimation;
  late Animation<Color?> _colorBgAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _idleAnimation;
  late Animation<double> _badgeAnimation;

  bool _isOnViewport = false;
  bool _isMounted = true;

  _ItemAnimation? _itemAnimation;

  @override
  bool get isBeginning => widget.isBeginning;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(duration: _idleDuration, vsync: this);
    _colorController = AnimationController(duration: _colorDuration, vsync: this);
    _rotationController = AnimationController(duration: _rotationDuration, vsync: this);
    _badgeController = AnimationController(duration: _badgeDuration, vsync: this);

    _setUpAnimations();
    _addListeners();
    _startIdling();
  }

  @override
  void dispose() {
    _idleController.dispose();
    _colorController.dispose();
    _rotationController.dispose();
    _badgeController.dispose();
    _isMounted = false;
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

  Offset get _translatePractice => isBeginning ? Offset(widget.radius, 0) : Offset(widget.radius / 2 + 2, 0);

  Offset get _translateProfile => isBeginning ? Offset(widget.radius, 1) : Offset(widget.radius / 2 + 4, -1);

  Offset get _endPosition  => widget.item.featurePlacement?.isDashboard ?? false
      ? _definePosition(kNavigationBarItemPractice).translate(_translatePractice.dx, _translatePractice.dy)
      : _definePosition(kNavigationBarItemProfile).translate(_translateProfile.dx, _translateProfile.dy);

  Offset get _startPosition => _definePosition(_buttonKey);

  void _setUpAnimations() {
    _setUpItemColorAnimation(widget.item, widget.item);

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_rotationController);

    _idleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_idleController);

    _badgeAnimation = Tween<double>(
      begin: widget.item.isCompleted ? 1.0 : 0.0,
      end: 1.0,
    ).animate(_badgeController);
  }

  void _clearItemAnimation() => _itemAnimation = null;

  void _setUpItemColorAnimation(RiverModuleItem begin, RiverModuleItem end) {
    _colorIconAnimation = ColorTween(
      begin: getIconColor(begin),
      end: getIconColor(end),
    ).animate(_colorController);

    _colorBgAnimation = ColorTween(
      begin: getBackgroundColor(begin),
      end: getBackgroundColor(end),
    ).animate(_colorController);
  }

  void _addListeners() {
    _colorController.addStatusListener(_colorListener);
    _rotationController.addStatusListener(_rotationListener);
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
        _runTransition();
      } else {
        _completeOrClearAction();
      }
    }
  }

  void _completeOrClearAction() {
    if (widget.item.isCompleted) {
      _runComplete();
    } else {
      _clearItemAnimation();
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

  void _transitionCompleted() {
    widget.onTransitionComplete?.call(widget.item.featurePlacement!);
    _completeOrClearAction();
  }

  void _startIdling() {
    if (widget.item.isUnLocked) {
      Future.delayed(_idleDelayDuration, () {
        if (_isMounted) _idleController.repeat(reverse: true);
      });
    }
  }

  void _runUnlock() {
    _colorController.forward();
  }

  void _runRead() {
    _idleController.reset();
    _rotationController.forward();
    _colorController.forward();
  }

  void _runTransition() {
    _showTransitionItemAnimation(
      context: context,
      startPosition: _startPosition,
      endPosition: _endPosition,
      onEnd: _transitionCompleted,
      item: _RiverItemFootprint(
        key: ValueKey(widget.item.id),
        item: widget.item,
        radius: widget.radius,
        isBeginning: isBeginning,
      ),
    );
  }

  void _runComplete() {
    _badgeController.forward();
  }

  void onViewPortChanged(VisibilityInfo info) {
    _isOnViewport = info.visibleFraction > 0;
    _startAnimation();
  }
}

enum _ItemAnimation {
  unlock,
  readAndComplete,
  complete,
}

Offset _definePosition(GlobalKey key) {
  final itemContext = key.currentContext;
  if (itemContext == null) {
    throw FlutterError('No context in item');
  }

  final RenderBox button = itemContext.findRenderObject()! as RenderBox;
  final RenderBox overlay = Navigator.of(kOverlayContext).overlay!.context.findRenderObject()! as RenderBox;

  return button.localToGlobal(Offset.zero, ancestor: overlay);
}