import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedRotationWrapper extends StatefulWidget {
  final Widget child;


  const AnimatedRotationWrapper({
    super.key,
    required this.child,

  });

  @override
  State<AnimatedRotationWrapper> createState() => _AnimatedRotationWrapperState();
}

class _AnimatedRotationWrapperState extends State<AnimatedRotationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;

  final duration = const Duration(seconds:2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    )
      ..forward();
    _rotateAnimation = Tween<double>(begin: 0.0, end: 6.0)
        .chain(CurveTween(curve: Curves.ease))
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
          child: widget.child.animate()
              .shimmer(delay: 600.ms, duration: 1800.ms),
        );
      },
    );
  }
}
