import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAnimationRenderer extends StatelessWidget {
  final String? url;

  const RiveAnimationRenderer({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      'assets/animations/audio_lesson_animation.riv',
      fit: BoxFit.cover,
    );
  }
}
