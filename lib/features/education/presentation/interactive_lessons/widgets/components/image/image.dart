import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';

class LessonImage extends StatelessWidget {
  final InteractiveLessonChunkComponentImage component;

  const LessonImage({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      component.content.src,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.error));
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
