import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ReportSectionTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const ReportSectionTitle({
    super.key,
    required this.title,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w400,
    this.color = AppColors.orangeDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            fontFamily: ThemeConstants.bitterFontFamily,
          ),
        ).tr(),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
