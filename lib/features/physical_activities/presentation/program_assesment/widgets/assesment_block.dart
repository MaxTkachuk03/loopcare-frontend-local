import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 27.0,
        horizontal: 24.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocalizedTexts.howHard.translation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20.0),
          ScoringScale(
            selectedScore: selectedScore,
            onScoreTap: _onCellTap,
          ),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocalizedTexts.veryEasy.translation,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.greyMid,
                    ),
              ),
              Text(
                LocalizedTexts.veryHard.translation,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.greyMid,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
        ],
      ),
    );
  }

  void _onCellTap(int index) {
    setState(() {
      selectedScore = index;
      widget.onScoreChange(index);
    });
  }
}
