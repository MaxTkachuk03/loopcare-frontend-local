import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAnimationRenderer extends StatelessWidget {
  final String? url;

  const RiveAnimationRenderer({
    super.key,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      'assets/animations/new_audio_lesson_animation.riv',
      fit: BoxFit.cover,
    );
  }
}
