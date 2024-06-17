import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AnimatedStateWrapper extends StatefulWidget {
  final Widget child;

  final Function() animate;

  const AnimatedStateWrapper({
    super.key,
    required this.child,
    required this.animate,
  });

  @override
  State<AnimatedStateWrapper> createState() => _AnimatedStateWrapperState();
}

class _AnimatedStateWrapperState extends State<AnimatedStateWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;

  final duration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    )
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.animate.call();
        }
      });
    _rotateAnimation = Tween<double>(begin: 0.0, end: 5.0)
        .chain(CurveTween(curve: Curves.easeOutQuart))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(math.pi * _rotateAnimation.value),
          child: widget.child,
        );
      },
    );
  }
}
