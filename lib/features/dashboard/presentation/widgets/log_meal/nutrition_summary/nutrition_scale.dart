import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/nutrition_indicator/nutrition_indicator.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class NutritionScale extends StatelessWidget {
  final String topLabel;
  final String bottomLabel;
  final Color color;
  final String indicatorLabel;

  const NutritionScale({
    super.key,
    required this.topLabel,
    required this.bottomLabel,
    required this.color,
    required this.indicatorLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText.w600(topLabel, style: context.textTheme.bodySmall),
        const SizedBox(height: 8.0),
        NutritionIndicator.small(label: indicatorLabel, color: color),
        const SizedBox(height: 8.0),
        CustomText.w600(bottomLabel, style: context.textTheme.bodySmall),
      ],
    );
  }
}
