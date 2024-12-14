import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/ordering/custom_reorderable_list.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

class Ordering extends StatelessWidget {
  final InteractiveLessonChunkComponentOrdering component;
  final RiverModuleStreamType lessonStreamType;
  final Function(
          InteractiveLessonComponentProgress progress, InteractiveLessonChunkComponent component)
      onSaveProgress;

  const Ordering({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.interactiveLesson(
          label: LocalizedTexts.interactiveLessonsOrderingLabel.tr(),
          lessonStreamType: lessonStreamType,
        ),
        const SizedBox(height: 20),
        CustomText(component.content.question),
        const SizedBox(height: 20),
        CustomReorderableList(
          component: component,
          lessonStreamType: lessonStreamType,
          onSaveProgress: onSaveProgress,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
