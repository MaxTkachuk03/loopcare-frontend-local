import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';

class Paragraph extends StatelessWidget {
  final InteractiveLessonChunkComponentParagraph component;

  const Paragraph({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      component.content.paragraph,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
