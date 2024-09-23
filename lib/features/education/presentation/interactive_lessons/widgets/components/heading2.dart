import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';

class Heading2 extends StatelessWidget {
  final InteractiveLessonChunkComponentHeading2 component;

  const Heading2({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      component.content.title,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
