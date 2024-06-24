import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rxdart/rxdart.dart';

const duration = Duration(seconds: 2);

class AnimatedScaleWrapper extends StatefulWidget {
  final Widget child;
  final AnimationController controller;

  const AnimatedScaleWrapper({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedScaleWrapperState();
}

class _AnimatedScaleWrapperState extends State<AnimatedScaleWrapper> {

  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    final scaleTween = Tween(begin: 1.0, end: 1.1);
    _scaleAnimation = scaleTween.animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        if (child != null) {
          return child.animate(onPlay: (controller) => controller.repeat(),)
              .scaleXY(begin: 1.0,
              end: 1.1,
              delay: 300.ms,
              duration: 1000.ms,
              curve: Curves.easeInQuint)
              .scaleXY(begin: 1.1,
              end: 1.0,
              delay: 300.ms,
              duration: 1000.ms,
              curve: Curves.easeInQuint)
              .shimmer(delay: 600.ms, duration: 1800.ms);
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}
