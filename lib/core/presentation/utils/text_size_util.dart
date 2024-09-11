import 'package:flutter/rendering.dart';

double textHeight(
  String text,
  double maxWidth, [
  TextStyle? style,
  TextScaler textScaler = TextScaler.noScaling,
]) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textScaler: textScaler,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);
  return textPainter.height;
}
