import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';

class MainContainer extends StatelessWidget {
  final Widget child;
  final InteractiveLessonChunkComponent? component;

  const MainContainer({super.key, required this.child, this.component});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20.0),
      child: child,
    );
  }
}
