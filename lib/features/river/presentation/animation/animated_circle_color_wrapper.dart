import 'package:flutter/material.dart';

const duration = Duration(seconds: 1);

class AnimatedCircleColorWrapper extends StatefulWidget {
  final Color newBgColor;
  final Color oldBgColor;
  final double circleRadius;
  final Widget icon;

  const AnimatedCircleColorWrapper({
    super.key,
    required this.icon,
    required this.newBgColor,
    required this.oldBgColor,
    this.circleRadius = 25,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedColorWrapperState();
}

class _AnimatedColorWrapperState extends State<AnimatedCircleColorWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: duration, vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..forward();
    _animation = ColorTween(
      begin: widget.oldBgColor,
      end: widget.newBgColor,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
            backgroundColor: _animation.value, radius: widget.circleRadius, child: widget.icon);
  }
}
