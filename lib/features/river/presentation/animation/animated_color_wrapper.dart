import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/river/domain/module_item/module_item.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';

const duration = Duration(seconds: 1);

class AnimatedColorWrapper extends StatefulWidget {
  final Color newIconColor;
  final Color oldIconColor;
  final double sizeIcon;
  final IconData icon;

  const AnimatedColorWrapper({
    super.key,
    required this.icon,
    required this.newIconColor,
    required this.oldIconColor,
    this.sizeIcon = 36,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedColorWrapperState();
}

class _AnimatedColorWrapperState extends State<AnimatedColorWrapper>
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
