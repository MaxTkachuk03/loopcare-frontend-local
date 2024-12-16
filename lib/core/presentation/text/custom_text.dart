import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  factory CustomText.bitter300(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w300,
        ),
      );

  factory CustomText.bitter400(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w400,
        ),
      );

  factory CustomText.bitter500(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w500,
        ),
      );

  factory CustomText.bitter600(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w600,
        ),
      );

  factory CustomText.bitter700(
    String text, {
    TextStyle? style,
    TextOverflow? overflow,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: style?.copyWith(
          fontFamily: ThemeConstants.bitterFontFamily,
          fontWeight: FontWeight.w700,
        ),
      );

  factory CustomText.w400(
    String text, {
    TextStyle? style,
    TextOverflow? overflow,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: style?.copyWith(fontWeight: FontWeight.w400),
      );

  factory CustomText.w400twoLineItalic(
    String text, {
    TextStyle? style,
    TextOverflow? overflow,
    TextAlign? textAlign,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: 2,
        style: style?.copyWith(
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
      );

  factory CustomText.w500(
    String text, {
    TextStyle? style,
    TextOverflow? overflow,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: style?.copyWith(fontWeight: FontWeight.w500),
      );

  factory CustomText.w600(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: style?.copyWith(fontWeight: FontWeight.w600),
      );

  factory CustomText.w700(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) =>
      CustomText(
        text,
        textAlign: textAlign,
        overflow: overflow,
        style: style?.copyWith(fontWeight: FontWeight.w700),
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: style,
      maxLines: maxLines,
      softWrap: true,
    );
  }
}
