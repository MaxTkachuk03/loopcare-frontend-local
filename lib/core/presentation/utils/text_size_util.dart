import 'package:flutter/rendering.dart';

double textHeight(String text, double maxWidth, [TextStyle? style]) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )
    ..layout(maxWidth: maxWidth);
  return textPainter.height;
}