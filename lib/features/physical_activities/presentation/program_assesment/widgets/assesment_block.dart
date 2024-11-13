import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class AssesmentBlock extends StatefulWidget {
  final void Function(int score) onScoreChange;

  const AssesmentBlock({
    super.key,
    required this.onScoreChange,
  });

  @override
  State<AssesmentBlock> createState() => _AssesmentBlockState();
}

class _AssesmentBlockState extends State<AssesmentBlock> {
  int? selectedScore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText.bitter600(
          LocalizedTexts.howHard.tr(),
          style: context.textTheme.bodyLarge,
        ),
        const SizedBox(height: 25.0),
        ScoringScale(
          selectedScore: selectedScore,
          selectedColor: AppColors.yellowRegular,
          scaleSize: 10,
          borderColor: AppColors.blueDarker,
          divColor: AppColors.blueLighter,
          onScoreTap: _onCellTap,
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText.w600(
              LocalizedTexts.veryEasy.tr(),
              style: context.textTheme.bodySmall,
            ),
            CustomText.w600(
              LocalizedTexts.veryHard.tr(),
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  void _onCellTap(int index) {
    setState(() {
      selectedScore = index;
      widget.onScoreChange(index + 1);
    });
  }
}
