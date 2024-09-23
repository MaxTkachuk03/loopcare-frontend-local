import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';

class Heading3 extends StatelessWidget {
  final InteractiveLessonChunkComponentHeading3 component;

  const Heading3({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      component.content.title,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
