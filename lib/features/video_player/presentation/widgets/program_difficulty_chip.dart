import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ProgramDifficultyChip extends StatelessWidget {
  final String text;

  const ProgramDifficultyChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      decoration: const BoxDecoration(color: AppColors.blueMid, borderRadius: BorderRadius.all(Radius.circular(7.0))),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
