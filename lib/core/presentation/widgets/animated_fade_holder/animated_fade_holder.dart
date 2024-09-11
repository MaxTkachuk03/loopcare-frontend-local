import 'package:flutter/material.dart';

class AnimatedFadeHolder extends StatefulWidget {
  const AnimatedFadeHolder._instance({
    super.key,
    this.duration,
    required this.child,
    required this.addStackCover,
  });

  factory AnimatedFadeHolder({
    Key? key,
    Duration? duration,
    required Widget child,
  }) {
    assert(child.key != null, '[child] mast have key parameter');

    return AnimatedFadeHolder._instance(
      key: key,
      duration: duration,
      addStackCover: false,
      child: child,
    );
  }

  factory AnimatedFadeHolder.positioned({
    Key? key,
    Duration? duration,
    required Widget child,
  }) {
    assert(child.key != null, '[child] mast have key parameter');

    return AnimatedFadeHolder._instance(
      key: key,
      duration: duration,
      addStackCover: true,
      child: child,
    );
  }

  final Widget child;
  final Duration? duration;
  final bool addStackCover;

  @override
  State<AnimatedFadeHolder> createState() => _AnimatedFadeHolderState();
}

class _AnimatedFadeHolderState extends State<AnimatedFadeHolder> with TickerProviderStateMixin {
  late Widget _oldChild;

  late final AnimationController _forwardController;
  late final AnimationController _reverseController;
  late final Animation<double> _forwardOpacityAnimation;
  late final Animation<double> _reverseOpacityAnimation;

  Widget _prepareChild(Widget? child) {
    if (child == null) {
      throw FlutterError('No child implemented');
    } else if (widget.addStackCover) {
      return Stack(
        children: [
          child,
        ],
      );
    } else {
      return child;
    }
  }

  @override
  void initState() {
    super.initState();
    _oldChild = widget.child;
    _forwardController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )..addListener(() {
        if (_forwardController.status == AnimationStatus.completed) {
          setState(() {
            _oldChild = widget.child;
            _reverseController.reset();
            _forwardController.reset();
          });
        }
      });

    _reverseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    )..addListener(() {
        if (_reverseController.status == AnimationStatus.completed) {
          _forwardController.forward(from: 0);
        }
      });

    _forwardOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_forwardController);

    _reverseOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_reverseController);
  }

  @override
  void didUpdateWidget(covariant AnimatedFadeHolder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child.key != oldWidget.child.key) {
      _reverseController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _reverseOpacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _reverseOpacityAnimation.value,
              child: _prepareChild(child),
            );
          },
          child: _oldChild,
        ),
        AnimatedBuilder(
          animation: _forwardOpacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _forwardOpacityAnimation.value,
              child: _prepareChild(child),
            );
          },
          child: widget.child,
        ),
      ],
    );
  }
}
