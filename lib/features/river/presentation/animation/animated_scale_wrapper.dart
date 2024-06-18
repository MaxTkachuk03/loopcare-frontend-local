import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedScaleWrapper extends StatefulWidget {
  final Widget child;

  const AnimatedScaleWrapper({
    super.key,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedScaleWrapperState();
}

class _AnimatedScaleWrapperState extends State<AnimatedScaleWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: 600.ms,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child
        .animate(onPlay: (controller) => controller.repeat())
        // .shimmer(delay: 600.ms, duration: 1800.ms) // shimmer +
        .scaleXY(begin: 1.0, end: 1.1, delay: 300.ms, duration: 1000.ms, curve: Curves.easeInQuint);
  }
}
