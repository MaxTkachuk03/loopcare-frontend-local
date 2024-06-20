import 'package:flutter/material.dart';

const duration = Duration(seconds: 1);

class AnimatedIconColorWrapper extends StatefulWidget {
  final Color newIconColor;
  final Color oldIconColor;
  final double sizeIcon;
  final IconData icon;

  const AnimatedIconColorWrapper({
    super.key,
    required this.icon,
    required this.newIconColor,
    required this.oldIconColor,
    this.sizeIcon = 36,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedIconColorWrapperState();
}

class _AnimatedIconColorWrapperState extends State<AnimatedIconColorWrapper>
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
      begin: widget.oldIconColor,
      end: widget.newIconColor,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon,
      color: _animation.value,
      size: widget.sizeIcon,
    );
  }
}
