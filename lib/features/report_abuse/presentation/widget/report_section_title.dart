import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ReportSectionTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? color;

  const ReportSectionTitle({
    super.key,
    required this.title,
    this.style,
    this.textAlign,
    this.color = AppColors.orangeDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText.bitter600(
          title.tr(),
          textAlign: textAlign,
          style: style,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
