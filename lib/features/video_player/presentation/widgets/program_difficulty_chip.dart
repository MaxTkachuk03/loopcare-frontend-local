import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class ProgramDifficultyChip extends StatelessWidget {
  final String text;

  const ProgramDifficultyChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      decoration:
          const BoxDecoration(color: AppColors.petrolRegular, borderRadius: BorderRadius.all(Radius.circular(7.0))),
      child: CustomText.w600(
        text.toUpperCase(),
        style: context.textTheme.bodySmall?.copyWith(
          color: AppColors.white,
          fontSize: ThemeConstants.fontSize12,
        ),
      ),
    );
  }
}
