import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class DifficultyLabel extends StatelessWidget {
  final String text;

  const DifficultyLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: const BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(3.0),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: ThemeConstants.fontSize10,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
