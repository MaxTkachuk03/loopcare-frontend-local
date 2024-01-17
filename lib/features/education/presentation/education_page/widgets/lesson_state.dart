import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class LessonState extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;

  const LessonState({super.key, required this.backgroundColor, required this.icon});

  factory LessonState.locked() => const LessonState(
        backgroundColor: AppColors.coralRegular,
        icon: Icons.lock,
      );

  factory LessonState.completed() => const LessonState(
        backgroundColor: AppColors.greenRegular,
        icon: Icons.check,
      );

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10.0,
      backgroundColor: backgroundColor,
      child: Icon(icon, size: 12),
    );
  }
}
