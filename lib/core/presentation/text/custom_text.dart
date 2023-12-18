import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const CustomText(this.text, {super.key, this.style, this.textAlign});

  factory CustomText.bitter400(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w400,
        ),
      );

  factory CustomText.bitter500(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w500,
        ),
      );

  factory CustomText.bitter600(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w600,
        ),
      );

  factory CustomText.bitter700(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w700,
        ),
      );

  factory CustomText.w400(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(fontWeight: FontWeight.w400),
      );

  factory CustomText.w500(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(fontWeight: FontWeight.w500),
      );

  factory CustomText.w600(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(fontWeight: FontWeight.w600),
      );

  factory CustomText.w700(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        style: style?.copyWith(fontWeight: FontWeight.w700),
      );

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: textAlign, style: style).tr();
  }
}
