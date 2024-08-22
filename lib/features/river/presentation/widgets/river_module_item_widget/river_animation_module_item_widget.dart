import 'dart:math' as math;

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/custom_navigation_bar/animated_bottom_bar.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/domain/feature_placement.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item_animation_state.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_item_widget/river_module_button.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_item_widget/river_module_item_preview.dart';
import 'package:visibility_detector/visibility_detector.dart';

part 'parts/_flying_item.dart';
part 'parts/_river_item_footprint.dart';

const _defaultItemRadius = 25.0;
const _idleDuration = Duration(milliseconds: 2000);
const _bouncedDuration = Duration(milliseconds: 150);
const _bouncedFullDuration = Duration(milliseconds: 900);
const _idleDelayDuration = Duration(milliseconds: 1000);
const _colorDuration = Duration(milliseconds: 1000);
const _rotationDuration = Duration(milliseconds: 1000);
const _unlockDuration = Duration(milliseconds: 1000);
const _badgeDuration = Duration(milliseconds: 300);

class RiverAnimationModuleItemWidget extends StatefulWidget {
  final RiverModuleItem item;
  final double radius;
  final Function()? onTap;
  final Function(FeaturePlacement? placement)? onAnimationComplete;
  final bool isBeginning;

  const RiverAnimationModuleItemWidget({
    super.key,
    required this.item,
    this.radius = _defaultItemRadius,
    this.isBeginning = false,
    this.onTap,
    this.onAnimationComplete,
  });

  @override
  State<RiverAnimationModuleItemWidget> createState() => _RiverAnimationModuleItemWidgetState();
}

class _RiverAnimationModuleItemWidgetState extends State<RiverAnimationModuleItemWidget>
    with TickerProviderStateMixin, RiverUtils {
  final GlobalKey _buttonKey = GlobalKey();

  late AnimationController _sizeController;
  late AnimationController _colorController;
  late AnimationController _rotationController;
  late AnimationController _badgeController;

  late Animation<Color?> _colorIconAnimation;
  late Animation<Color?> _colorBgAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _badgeAnimation;

  late RiverModuleItemAnimationState _itemAnimation;

  bool _isOnViewport = false;
  bool _isMounted = true;

  @override
  bool get isBeginning => widget.isBeginning;

  @override
  void initState() {
    super.initState();

    _sizeController = AnimationController(duration: _idleDuration, vsync: this);
    _colorController = AnimationController(duration: _colorDuration, vsync: this);
    _rotationController = AnimationController(duration: _rotationDuration, vsync: this);
    _badgeController = AnimationController(duration: _badgeDuration, vsync: this);

    _itemAnimation = widget.item.states.animationState;

    _setUpAnimations();
    _setUpItemColorAnimation(widget.item);
    _addListeners();
    _startAnimation();
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _colorController.dispose();
    _rotationController.dispose();
    _badgeController.dispose();
    _isMounted = false;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RiverAnimationModuleItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setUpItemColorAnimation(widget.item);
    _setUpAnimations();

    _itemAnimation = widget.item.states.animationState;
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animated_module_item_${widget.item.hashCode}'),
      onVisibilityChanged: _onViewPortChanged,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          AnimatedBuilder(
            animation: _colorController,
            builder: (context, _) => AnimatedBuilder(
              animation: _sizeController,
              builder: (context, _) => AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) => Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(math.pi * _rotateAnimation.value)
                    ..scale(_sizeAnimation.value, _sizeAnimation.value),
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
      ),
    );
  }

  Offset get _translatePractice => isBeginning
      ? Offset(widget.radius - 2, 0)
      : Offset(widget.radius / 2, - widget.radius / 2 + 2);

  Offset get _translateProfile => isBeginning
      ? Offset(widget.radius + 2, 0)
      : Offset(widget.radius / 2 + 4, -1);

  Offset get _endPosition  => widget.item.featurePlacement?.isDashboard ?? false
      ? _definePosition(kNavigationBarItemPractice).translate(_translatePractice.dx, _translatePractice.dy)
      : _definePosition(kNavigationBarItemProfile).translate(_translateProfile.dx, _translateProfile.dy);

  Offset get _startPosition => _definePosition(_buttonKey);

  void _setUpAnimations() {
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_rotationController);

    _sizeAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_sizeController);

    _badgeAnimation = Tween<double>(
      begin: widget.item.states.prevItemState.isCompleted ? 1.0 : 0.0,
      end: widget.item.states.itemState.isRead ? 0.0 : 1.0,
    ).animate(_badgeController);
  }

  void _clearItemAnimation() {
    widget.onAnimationComplete?.call(null);
    _itemAnimation = RiverModuleItemAnimationState.no;
  }

  void _setUpItemColorAnimation(RiverModuleItem item) {
    _colorIconAnimation = ColorTween(
      begin: getIconColor(item.states.prevItemState, item.streamType, item.isRootItem),
      end: getIconColor(item.states.itemState, item.streamType, item.isRootItem),
    ).animate(_colorController);

    _colorBgAnimation = ColorTween(
      begin: getBackgroundColor(item.states.prevItemState, item.streamType, item.isRootItem),
      end: getBackgroundColor(item.states.itemState, item.streamType, item.isRootItem),
    ).animate(_colorController);
  }

  void _addListeners() {
    _colorController.addStatusListener(_colorListener);
    _rotationController.addStatusListener(_rotationListener);
    _badgeController.addStatusListener(_badgeListener);
  }

  void _colorListener(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      _runIdling();

      if (widget.item.states.itemState.isUnLocked) {
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
    if (widget.item.states.itemState.isCompleted) {
      _runComplete();
    } else {
      _clearItemAnimation();
    }
  }

  void _badgeListener(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      _clearItemAnimation();
    }
  }

  void _startAnimation() {
    if (_isOnViewport) {
      switch (_itemAnimation) {
        case RiverModuleItemAnimationState.unlock:
          _runUnlock();
        case RiverModuleItemAnimationState.read:
          _runRead();
        case RiverModuleItemAnimationState.complete:
        case RiverModuleItemAnimationState.reversCompletion:
          _runComplete();
        case RiverModuleItemAnimationState.idling:
          _runIdling();
        case RiverModuleItemAnimationState.bounced:
          _runBounced();
        default:
          return;
      }
    }
  }

  void _transitionCompleted() {
    widget.onAnimationComplete?.call(widget.item.featurePlacement!);
    _completeOrClearAction();
  }

  void _runIdling() {
    if (widget.item.states.itemState.isUnLocked) {
      Future.delayed(_idleDelayDuration, () {
        if (_isMounted) _sizeController.repeat(reverse: true);
      });
    }
  }

  void _runUnlock() {
    _colorController.forward();
  }

  void _runRead() {
    _colorController.forward();
    _sizeController.reset();
    _rotationController.forward();
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

  void _runBounced() async {
    final isIdling = _sizeController.isAnimating;
    if (isIdling) {
      _sizeController.reset();
    }

    _sizeController
      ..duration = _bouncedDuration
      ..reverseDuration = _bouncedDuration;

    _sizeController.repeat(reverse: true);

    await Future.delayed(_bouncedFullDuration);
    _sizeController.reset();
    _clearItemAnimation();

    if (isIdling) {
      _sizeController
        ..duration = _idleDuration
        ..reverseDuration = _idleDuration;

      _sizeController.repeat(reverse: true);
    }
  }

  void _onViewPortChanged(VisibilityInfo info) {
    _isOnViewport = info.visibleFraction > 0;
    _startAnimation();
  }
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