import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_indicator_size.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class NutritionIndicator extends StatelessWidget {
  final String label;
  final Color color;
  final NutritionIndicatorSize layoutSize;

  const NutritionIndicator({
    super.key,
    required this.color,
    required this.label,
    this.layoutSize = NutritionIndicatorSize.small,
  });

  factory NutritionIndicator.big({required Color color, required String label}) =>
      NutritionIndicator(color: color, label: label, layoutSize: NutritionIndicatorSize.big);

  factory NutritionIndicator.small({required Color color, required String label}) =>
      NutritionIndicator(color: color, label: label, layoutSize: NutritionIndicatorSize.small);

  TextStyle? _textStyle(BuildContext context) => layoutSize == NutritionIndicatorSize.big
      ? context.textTheme.displayMedium
      : context.textTheme.bodySmall;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: layoutSize.width,
      height: layoutSize.width,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.blueDarker,
          borderRadius: BorderRadius.all(Radius.circular(layoutSize.width / 2)),
          border:
              Border.all(width: layoutSize.borderThickness, color: color, style: BorderStyle.solid),
        ),
        child: Align(
          alignment: Alignment.center,
          child: FittedBox(
            child: CustomText.w600(
              label,
              style: _textStyle(context)?.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
