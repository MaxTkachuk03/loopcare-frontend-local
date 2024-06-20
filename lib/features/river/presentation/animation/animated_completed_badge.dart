import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class AnimatedCompletedBadge extends StatelessWidget {
  final double sizeBadge;

  const AnimatedCompletedBadge({super.key, required this.sizeBadge});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.ease,
      duration: const Duration(seconds: 4),
      builder: (BuildContext context, double opacity, Widget? child) {
        return Opacity(
          opacity: opacity,
          child: badge.Badge(
            badgeStyle: const badge.BadgeStyle(
              padding: EdgeInsets.all(5),
              badgeColor: AppColors.blueRegular,
              elevation: 0,
            ),
            badgeAnimation: const badge.BadgeAnimation.slide(toAnimate: false),
            position: badge.BadgePosition.topEnd(top: -8, end: -4),
            badgeContent: Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Icon(
                Icons.check,
                color: AppColors.white,
                size: sizeBadge,
              ),
            ),
          ),
        );
      },
    );
  }
}