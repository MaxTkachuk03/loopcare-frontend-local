import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownRenderer extends StatelessWidget {
  final String data;
  final MarkdownStyleSheet styleSheet;

  const MarkdownRenderer({super.key, required this.data, required this.styleSheet});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: data,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      styleSheet: styleSheet,
    );
  }
}
