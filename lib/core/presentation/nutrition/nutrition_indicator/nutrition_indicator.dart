import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/nutrition/nutrition_indicator_size.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class NutritionIndicator extends StatelessWidget {
  final String label;
  final Color color;
  final NutritionIndicatorSize layoutSize;
  final double progress;

  const NutritionIndicator({
    super.key,
    required this.color,
    required this.label,
    this.layoutSize = NutritionIndicatorSize.small,
    this.progress = 0.0,
  });

  factory NutritionIndicator.big(
          {required Color color, required String label, double? progress}) =>
      NutritionIndicator(
        color: color,
        label: label,
        layoutSize: NutritionIndicatorSize.big,
        progress: progress ?? 0.0,
      );

  factory NutritionIndicator.small(
          {required Color color, required String label, double? progress}) =>
      NutritionIndicator(
        color: color,
        label: label,
        layoutSize: NutritionIndicatorSize.small,
        progress: progress ?? 0.0,
      );

  TextStyle? _textStyle(BuildContext context) =>
      layoutSize == NutritionIndicatorSize.big
          ? context.textTheme.displayMedium
          : context.textTheme.bodySmall;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: layoutSize.width,
      height: layoutSize.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.blueDarker,
              borderRadius:
                  BorderRadius.all(Radius.circular(layoutSize.width / 2)),
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
          Positioned.fill(
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              value: progress,
              strokeWidth: 8.0,
              valueColor: const AlwaysStoppedAnimation(AppColors.greenRegular),
              backgroundColor: color,
            ),
          ),
        ],
      ),
    );
  }
}
