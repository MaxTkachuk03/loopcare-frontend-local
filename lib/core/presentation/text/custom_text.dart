import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const CustomText(this.text, {super.key, this.style, this.textAlign});

  factory CustomText.bitter(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(fontFamily: ThemeConstants.bitterFontFamily),
      );

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: textAlign, style: style).tr();
  }
}
