import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class TextWithAccents extends StatelessWidget {
  const TextWithAccents(
    this.text, {
    super.key,
    this.accents = const [],
    this.style,
    this.accentedStyle,
  });

  final String text;
  final List<String> accents;
  final TextStyle? style;
  final TextStyle? accentedStyle;

  List<String> _parts(String text, List<String> accents) {
    final pattern = accents.firstOrNull;
    if (accents.isNotEmpty && pattern != null && text.contains(pattern)) {
      final parts = text.split(accents.first);
      final start = parts.first.length + accents.first.length;
      final secondPart = text.substring(start);
      return [parts.first, accents.first, ..._parts(secondPart, accents.sublist(1))];
    } else {
      return [text];
    }
  }

  @override
  Widget build(BuildContext context) {
    final parts = _parts(text, accents);
    final regularStyle = style ?? context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400);
    final accentStyle = accentedStyle ?? context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);

    return RichText(
      text: TextSpan(
        children: parts
            .map(
              (value) => TextSpan(
                text: value,
                style: accents.contains(value) ? accentStyle : regularStyle,
              ),
            )
            .toList(),
      ),
    );
  }
}
