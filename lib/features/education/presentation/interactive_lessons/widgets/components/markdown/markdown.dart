import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:loopcare_frontend/core/presentation/markdown/markdown_renderer.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';

class Markdown extends StatelessWidget {
  final InteractiveLessonChunkComponentMarkdown component;

  const Markdown({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return MarkdownRenderer(
      data: component.content.markdown,
      styleSheet: MarkdownStyleSheet(
        h1: context.textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: ThemeConstants.bitterFontFamily),
        h2: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: ThemeConstants.bitterFontFamily),
        h3: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: ThemeConstants.bitterFontFamily),
        p: context.textTheme.bodyMedium!,
      ),
    );
  }
}
