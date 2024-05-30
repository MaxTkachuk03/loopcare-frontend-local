import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loopcare_frontend/core/presentation/animations/app_animations.dart';
import 'package:lottie/lottie.dart';

typedef OnLoadedCb = Function(LottieComposition)?;

// TODO very basic widget, will be extended in future
class LottieAnimation extends StatefulWidget {
  final String animationUrl;
  final bool repeat;
  final bool addRepaintBoundary;
  final Duration delay;
  final AnimationController? controller;
  final OnLoadedCb onLoaded;

  const LottieAnimation({
    super.key,
    required this.animationUrl,
    required this.controller,
    required this.onLoaded,
    this.repeat = false,
    this.addRepaintBoundary = true,
    this.delay = Duration.zero,
  });

  factory LottieAnimation.unlock({AnimationController? controller, OnLoadedCb onLoaded, Duration? delay}) =>
      LottieAnimation(
        animationUrl: AppAnimations.unlock,
        controller: controller,
        onLoaded: onLoaded,
        delay: delay ?? 0.ms,
      );

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? AnimationController(vsync: this);
  }

  void _onLoadedHandler(composition) async {
    if (widget.controller != null && widget.onLoaded != null) {
      widget.onLoaded?.call(composition);
      return;
    }

    _controller.duration = composition.duration;

    await Future.delayed(widget.delay);

    if (!mounted) return;

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.animationUrl,
      repeat: widget.repeat,
      addRepaintBoundary: widget.addRepaintBoundary,
      controller: _controller,
      onLoaded: _onLoadedHandler,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
