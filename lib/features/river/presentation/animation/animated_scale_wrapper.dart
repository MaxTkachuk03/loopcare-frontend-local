import 'package:flutter/material.dart';

const duration = Duration(seconds: 2);

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
  late Animation<double> _animation;

  double _squareScale = 1;

  @override
  void initState() {
    super.initState();

    final scaleTween = Tween(begin: 1.0, end: 1.1);
    _controller = AnimationController(duration: duration, vsync: this);
    _animation = scaleTween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    )..addListener(() {
        setState(() => _squareScale = _animation.value);
      });
    _animate();
  }

  void _animate() {
    _animation.addStatusListener((AnimationStatus status) {
      if (_squareScale == 1.1) {
        _controller.reverse();
      } else if (_squareScale == 1) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _squareScale,
      child: widget.child,
    );
  }
}
