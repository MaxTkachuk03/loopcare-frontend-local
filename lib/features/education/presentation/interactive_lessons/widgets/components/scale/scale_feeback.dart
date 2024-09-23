import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class ScaleFeedback extends StatelessWidget {
  final InteractiveLessonChunkComponentScale component;
  final int selectedScore;

  const ScaleFeedback({super.key, required this.component, required this.selectedScore});

  bool get hasFeedback =>
      component.content.feedback != null && component.content.feedback!.isNotEmpty;

  String get feedbackText => component.content.feedback!
      .firstWhere((e) => e.minValue <= selectedScore && e.maxValue >= selectedScore)
      .text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText.bitter600(LocalizedTexts.interactiveLessonsScaleFeedbackTitle.tr(),
              style: context.textTheme.bodyLarge),
          const SizedBox(height: 20),
          CustomText(feedbackText, style: context.textTheme.bodyMedium, textAlign: TextAlign.left),
        ],
      ),
    );
  }
}
