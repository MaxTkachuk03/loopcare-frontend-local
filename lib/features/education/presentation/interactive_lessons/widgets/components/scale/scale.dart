import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/scale/scale_bottom.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/components/scale/scale_feeback.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_component_progress.dart';

// TODO: Rewrite with animation like like/unlike component if there will be time
class Scale extends StatefulWidget {
  final InteractiveLessonChunkComponentScale component;
  final RiverModuleStreamType lessonStreamType;
  final Function(InteractiveLessonComponentProgress progress,
      InteractiveLessonChunkComponent component) onSaveProgress;
  final Function() scrollDown;

  const Scale({
    super.key,
    required this.component,
    required this.lessonStreamType,
    required this.onSaveProgress,
    required this.scrollDown,
  });

  @override
  State<Scale> createState() => _ScaleState();
}

class _ScaleState extends State<Scale> {
  int? _selectedScore;

  @override
  initState() {
    super.initState();
    if (widget.component.progress == null) return;
    final optionId = widget.component.progress!.optionId;
    _selectedScore = optionId;
  }

  void _onSelectedHandler(int value) {
    setState(() {
      _selectedScore = _selectedScore == value ? null : value;
    });

    widget.onSaveProgress(
        InteractiveLessonComponentProgress(optionId: _selectedScore),
        widget.component);

    widget.scrollDown();
  }

  bool get hasFeedback =>
      widget.component.content.feedback != null &&
      widget.component.content.feedback!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.interactiveLesson(
          label: LocalizedTexts.interactiveLessonsScaleLabel.tr(),
          lessonStreamType: widget.lessonStreamType,
        ),
        const SizedBox(height: 20),
        CustomText(
          widget.component.content.question,
          style: context.textTheme.bodyMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        ScoringScale(
          selectedColor: AppColors.greenRegular,
          selectedScore: _selectedScore,
          onScoreTap: _onSelectedHandler,
          scaleSize: widget.component.content.values.length,
          labels: widget.component.content.values.map((o) => o.label).toList(),
          borderColor: AppColors.blueDarker,
        ),
        const SizedBox(height: 14),
        ScaleBottom(content: widget.component.content),
        if (hasFeedback && _selectedScore != null)
          ScaleFeedback(
              component: widget.component, selectedScore: _selectedScore! + 1),
      ],
    );
  }
}
