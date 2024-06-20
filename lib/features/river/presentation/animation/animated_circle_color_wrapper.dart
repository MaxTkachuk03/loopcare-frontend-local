import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const duration = Duration(milliseconds: 360);

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
    return Container(
      decoration: BoxDecoration(
        color: _animation.value,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyLight.withOpacity(0.1),
            spreadRadius: 1.5,
            blurRadius: 1,
          ),
        ],
      ),
      width: 2 * widget.circleRadius,
      height: 2 * widget.circleRadius,
      child: widget.icon,
    ).animate()
        .shimmer(delay: 600.ms, duration: 1800.ms);
  }
}
