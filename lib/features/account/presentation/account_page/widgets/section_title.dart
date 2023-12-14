import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blueDark,
            fontFamily: ThemeConstants.bitterFontFamily,
          ),
        ).tr(),
        const SizedBox(height: 16.0),
        const Divider(height: 1.0, color: AppColors.yellowLight),
      ],
    );
  }
}
