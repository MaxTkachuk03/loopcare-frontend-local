import 'dart:async';

import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 1000);
const _reverseDuration = Duration(milliseconds: 300);
const _hidingDelay = Duration(seconds: 3);

class HidingBox extends StatefulWidget {
  const HidingBox({
    super.key,
    required this.isPlay,
    required this.child,
  });

  final bool isPlay;
  final Widget child;

  @override
  State<HidingBox> createState() => _HidingBoxState();
}

class _HidingBoxState extends State<HidingBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _duration,
      reverseDuration: _reverseDuration,
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    _toggleView();
  }

  void _toggleView() {
    if (widget.isPlay) {
      _timer?.cancel();
      _timer = Timer(_hidingDelay, _controller.forward);
    } else {
      _timer?.cancel();
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant HidingBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlay != oldWidget.isPlay) {
      _toggleView();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: IgnorePointer(
            ignoring: _opacityAnimation.value < 0.2,
            child: child!,
          ),
        );
      },
    );
  }
}
