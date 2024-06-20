import 'package:flutter/material.dart';

class AnimatedTransitionWrapper extends StatefulWidget {
  final Widget child;
  final Offset offset;

  const AnimatedTransitionWrapper(
      {super.key, required this.child, required this.offset});

  @override
  State<AnimatedTransitionWrapper> createState() => _AnimatedTransitionWrapperState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _AnimatedTransitionWrapperState extends State<AnimatedTransitionWrapper>
    with TickerProviderStateMixin {
  final ValueNotifier<bool> opacityController = ValueNotifier(false);
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..forward();
  late final Animation<Offset> _animation = Tween<Offset>(
    begin: widget.offset,
    //offset navigation bar item
    end: Offset(widget.offset.dx, widget.offset.dy + 100),
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        opacityController.value = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 4),
          builder: (BuildContext context, double opacity, Widget? child) {
            return Opacity(
              opacity: opacity,
              child: widget.child,
            );
          }),
    );
  }
}
