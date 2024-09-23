import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';
import 'package:loopcare_frontend/features/education/domain/interactive_lesson/interactive_lesson_chunk_component.dart';

class Scale extends StatefulWidget {
  final InteractiveLessonChunkComponentScale component;

  const Scale({super.key, required this.component});

  @override
  State<Scale> createState() => _ScaleState();
}

class _ScaleState extends State<Scale> {
  final int _selectedScore = 0;

  void _onSelectedHandler(int value) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryLabel.scale(),
        const SizedBox(height: 20),
        CustomText(
          widget.component.content.question,
          style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              widget.component.content.lowestText,
              style: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            CustomText(
              widget.component.content.highestText,
              style: context.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
